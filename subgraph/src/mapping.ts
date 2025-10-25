// AssemblyScript mappings (placeholders)
// Each handler creates entity by tx hash + log index composite id
import {
    IndexWeightsUpdated as IndexWeightsUpdatedEvent,
    DashboardSnapshot as DashboardSnapshotEvent,
    BondIssued as BondIssuedEvent,
    CouponsAccrued as CouponsAccruedEvent,
    BondBuyback as BondBuybackEvent,
    CutProposed as CutProposedEvent,
    CutQueued as CutQueuedEvent,
    CutExecuted as CutExecutedEvent,
    EmergencyBrake as EmergencyBrakeEvent,
    FunctionPaused as FunctionPausedEvent,
    PoRPosted as PoRPostedEvent,
    PoRSealed as PoRSealedEvent,
    RateSet as RateSetEvent,
    Triangulated as TriangulatedEvent,
    Redeemed as RedeemedEvent,
    FeeUpdated as FeeUpdatedEvent
} from '../generated/GrcDiamond/GrcDiamond'
import {
    IndexWeightsUpdated,
    DashboardSnapshot,
    BondIssued,
    CouponsAccrued,
    BondBuyback,
    CutProposed,
    CutQueued,
    CutExecuted,
    EmergencyBrake,
    FunctionPaused,
    PoRPosted,
    PoRSealed,
    RateSet,
    Triangulated,
    Redeemed,
    FeeUpdated,
    DailyLiCRISnapshot,
    GovernanceProposal,
    BondSeriesCouponSnapshot,
    LiCRIRollingWindow
} from '../generated/schema'
import { BigInt } from '@graphprotocol/graph-ts'

function makeId(hash: string, logIndex: string): string { return hash + '-' + logIndex }

// Integer square root via Newton-Raphson on BigInt (AssemblyScript BigInt wrapper from graph-ts)
function sqrtBigInt(value: BigInt): BigInt {
    if (value.le(BigInt.fromI32(1))) return value;
    let z = value;
    let x = value.div(BigInt.fromI32(2)).plus(BigInt.fromI32(1));
    while (x.lt(z)) {
        z = x;
        x = value.div(x).plus(x).div(BigInt.fromI32(2));
    }
    return z;
}

// Compute EMA using integer math: EMA_t = (val*2 + prev*(n-1)) / (n+1)
// Treat window as integer (number) due to mapping compilation environment.
function computeEMA(current: BigInt, prevEMA: BigInt | null, window: number): BigInt {
    let nPlus = BigInt.fromI32(window + 1);
    if (prevEMA == null) {
        return current; // seed with current value
    }
    let numerator = current.times(BigInt.fromI32(2)).plus(prevEMA.times(BigInt.fromI32(window - 1)));
    return numerator.div(nPlus);
}

export function handleIndexWeightsUpdated(event: IndexWeightsUpdatedEvent): void {
    let entity = new IndexWeightsUpdated(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    entity.indexId = event.params.id
    entity.version = event.params.version
    entity.save()
}
export function handleDashboardSnapshot(event: DashboardSnapshotEvent): void {
    // --- Granular isolation: rolling window analytics split, explicit null checks ---
    // Place after daily snapshot initialization and null check
    // --- Isolated: Daily snapshot initialization block commented for crash isolation ---
    // let secondsInDay = BigInt.fromI32(86400);
    let secondsInDay = BigInt.fromI32(86400);
    let dayStart = event.block.timestamp.minus(event.block.timestamp.mod(secondsInDay));
    let dayKey = dayStart.toI32().toString();
    let daily = DailyLiCRISnapshot.load(dayKey);
    if (daily == null) {
        daily = new DailyLiCRISnapshot(dayKey);
        daily.dayStart = dayStart;
        daily.lastLiCRI = event.params.liCRI;
        daily.globalVersion = event.params.globalVersion;
        daily.updates = 1;
        daily.cumulativeLiCRI = BigInt.fromI32(0);
        daily.cumulativeLiCRISquared = BigInt.fromI32(0);
    } else {
        daily.lastLiCRI = event.params.liCRI;
        daily.globalVersion = event.params.globalVersion;
        daily.updates = daily.updates + 1;
    }
    // Granular isolation: only cumulativeLiCRI assignment with strict null checks
    // Test: assign constant value to cumulativeLiCRI to confirm schema compatibility
    let prevDayStart = dayStart.minus(secondsInDay);
    let prevKey = prevDayStart.toI32().toString();
    let prevDaily = DailyLiCRISnapshot.load(prevKey);
    // Minimal fallback: assign only lastLiCRI to cumulativeLiCRI to confirm crash source
    daily.cumulativeLiCRI = daily.lastLiCRI;
    daily.save();
}
export function handleBondIssued(event: BondIssuedEvent): void {
    let e = new BondIssued(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.series = event.params.series
    e.to = event.params.to
    e.notional = event.params.notional
    e.save()
}
export function handleCouponsAccrued(event: CouponsAccruedEvent): void {
    let e = new CouponsAccrued(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.series = event.params.series
    e.amount = event.params.amount
    e.save()
    // daily bond coupon aggregation per series
    let secondsInDay = BigInt.fromI32(86400)
    let dayStart = event.block.timestamp.minus(event.block.timestamp.mod(secondsInDay))
    let seriesHex = event.params.series.toHexString()
    let key = seriesHex + '-' + dayStart.toI32().toString()
    let snap = BondSeriesCouponSnapshot.load(key)
    if (snap == null) {
        snap = new BondSeriesCouponSnapshot(key)
        snap.series = event.params.series
        snap.dayStart = dayStart
        snap.cumulativeCoupons = event.params.amount
        snap.updates = 1
    } else {
        snap.cumulativeCoupons = snap.cumulativeCoupons.plus(event.params.amount)
        snap.updates = snap.updates + 1
    }
    snap.save()
}
export function handleBondBuyback(event: BondBuybackEvent): void {
    let e = new BondBuyback(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.series = event.params.series
    e.principalClosed = event.params.principalClosed
    e.save()
}
export function handleCutProposed(event: CutProposedEvent): void {
    let e = new CutProposed(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.proposalId = event.params.id
    e.proposer = event.params.proposer
    e.init = event.params.init
    e.initData = event.params.initData
    e.save()
    let gpId = event.params.id.toHex()
    let gp = new GovernanceProposal(gpId)
    gp.proposer = event.params.proposer
    gp.init = event.params.init
    gp.initData = event.params.initData
    gp.eta = BigInt.fromI32(0)
    gp.executed = false
    gp.queued = false
    gp.createdAt = event.block.timestamp
    gp.save()
}
export function handleCutQueued(event: CutQueuedEvent): void {
    let e = new CutQueued(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.proposalId = event.params.id
    e.eta = event.params.eta
    e.save()
    let gpId = event.params.id.toHex()
    let gp = GovernanceProposal.load(gpId)
    if (gp != null) {
        gp.eta = event.params.eta
        gp.queued = true
        gp.save()
    }
}
export function handleCutExecuted(event: CutExecutedEvent): void {
    let e = new CutExecuted(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.proposalId = event.params.id
    e.save()
    let gpId = event.params.id.toHex()
    let gp = GovernanceProposal.load(gpId)
    if (gp != null) {
        gp.executed = true
        gp.executedAt = event.block.timestamp
        gp.save()
    }
}
export function handleEmergencyBrake(event: EmergencyBrakeEvent): void {
    let e = new EmergencyBrake(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.selector = event.params.selector
    e.paused = event.params.paused
    e.save()
}
export function handleFunctionPaused(event: FunctionPausedEvent): void {
    let e = new FunctionPaused(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.selector = event.params.selector
    e.paused = event.params.paused
    e.save()
}
export function handlePoRPosted(event: PoRPostedEvent): void {
    let e = new PoRPosted(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.period = event.params.period
    e.root = event.params.root
    e.ipfsRef = event.params.ipfsRef
    e.save()
}
export function handlePoRSealed(event: PoRSealedEvent): void {
    let e = new PoRSealed(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.period = event.params.period
    e.save()
}
export function handleRateSet(event: RateSetEvent): void {
    let e = new RateSet(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.fromAsset = event.params.fromAsset
    e.toAsset = event.params.toAsset
    e.rate = event.params.rate
    e.save()
}
export function handleTriangulated(event: TriangulatedEvent): void {
    let e = new Triangulated(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.fromAsset = event.params.fromAsset
    e.toAsset = event.params.toAsset
    e.inputAmount = event.params.inputAmount
    e.outputAmount = event.params.outputAmount
    e.save()
}
export function handleRedeemed(event: RedeemedEvent): void {
    let e = new Redeemed(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.fromAsset = event.params.fromAsset
    e.toAsset = event.params.toAsset
    e.inputAmount = event.params.inputAmount
    e.outputAmount = event.params.outputAmount
    e.save()
}
export function handleFeeUpdated(event: FeeUpdatedEvent): void {
    let e = new FeeUpdated(makeId(event.transaction.hash.toHex(), event.logIndex.toString()))
    e.oldFeeBps = event.params.oldFeeBps
    e.newFeeBps = event.params.newFeeBps
    e.save()
}

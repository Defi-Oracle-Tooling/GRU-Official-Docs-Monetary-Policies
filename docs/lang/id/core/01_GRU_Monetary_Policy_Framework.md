---
title: Kerangka Kebijakan Moneter GRU
version: 1.0.2
status: stabil
last_updated: 2026-05-25
layer: kebijakan
checksum: tertunda
lang: id
---
# Kerangka Kebijakan Moneter GRU

## Ikhtisar
Global Reserve Unit (GRU) menetapkan sistem moneter multi-tingkat yang didukung aset, menambatkan semua likuiditas melalui XAU (emas) untuk memastikan nilai intrinsik, paritas yang dapat diaudit, dan konvertibilitas lintas domain. Dalam praktik operasional, semua FX ditriangulasi melalui XAU dengan representasi on-chain `cXAUC/cXAUT`.

### Diagram Siklus Penerbitan
![Siklus Penerbitan GRU](/assets/media/issuance_cycle.png)
*Gambar: Cadangan → Penerbitan → Sirkulasi dengan loop daur ulang likuiditas dan pemeliharaan cakupan.*

## Rasio Inti
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Koefisien dinamis (x, y) adalah bobot distribusi yang disesuaikan kebijakan antara lapisan M0 (institusional) dan M1 (komersial).

## Nilai nominal yang ditetapkan vs nilai aset pendukung
```text
Nilai nominal / paritas (wajah, akuntansi, penyelesaian):
1 GRU = 1 XAU
1 M0 GRU = 1 XAU
1 M1 GRU = 1 XAU

Nilai aset pendukung (cakupan sisi cadangan):
1 M0 GRU = 1.2 XAU aset pendukung
1 M00 GRU = 6.0 XAU aset pendukung
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
Untuk menghindari kerancuan, nilai nominal yang ditetapkan dan nilai aset pendukung adalah ukuran yang berbeda. Nilai nominal adalah unit yang dipakai untuk paritas, pembukuan, penyelesaian, dan kontrol kebijakan. Nilai aset pendukung adalah besarnya aset cadangan yang diperlukan untuk menyangga unit tersebut pada suatu lapisan. Rumus singkat lama seperti `1 XAU GRU = 1.2 XAU` merujuk hanya pada nilai pendukung dan tidak mengubah paritas nominal `1 GRU = 1 XAU`.

LiXAU adalah indeks cadangan emas. Di dalam kerangka Li, ada lima komponen bernilai sama yang membentuk komposit operasional:
- `LiXAU` = indeks cadangan emas
- `LiPMG` = Precious Metals Group index
- `LiBMG1` = Base Metals Group index
- `LiBMG2` = Battery Materials Group index
- `LiBMG3` = Building Metals Group index

## Struktur Lapisan
| Lapisan | Fungsi | Deskripsi |
|-------|----------|-------------|
| M00 | Penerbitan Berdaulat | Penciptaan dasar terikat 1:1 dengan cadangan yang diaudit |
| M0  | Cadangan Institusional | Instrumen likuiditas tingkat antarbank & otoritas |
| M1  | Sirkulasi Komersial | Lapisan eMoney pasar & penyelesaian |

Pemetaan implementasi saat ini: aset `c*` kanonis di Chain 138 adalah instrumen GRU lapisan M1. Aset `cW*` di jaringan publik adalah representasi transport bermiror untuk lapisan GRU M1 yang sama dan bukan kelas moneter terpisah.

## Chain 138 (Defi Oracle Meta) — RWA indices vs M1 transport

*(English — authoritative for integrators; mirrors `docs/core/01` v1.0.2.)*

Chain 138 (`dfio_meta_main`, chainId **138**) hosts **two parallel tracks**. They must not be described as a single flow (“RWA → lock → CCIP → mint on public chains”) for all assets.

| Track | GRU layer | Symbols | Role on 138 | Public networks |
|-------|-----------|---------|-------------|-----------------|
| **Commodity / index RWA** | **M00** | **Li\*** (LiXAU, LiPMG, LiBMG1–3) | Institutional index instruments when deployed | DefiLlama **RWA** path when evidenced — **not** created via **cW\*** bridge escrow |
| **Compliant eMoney** | **M1** | **c\*** (cUSDT, cUSDC, cEURC, …) | Native hub issuance and settlement | **cW\*** wrapped transport (e.g. Ethereum, Optimism, BSC, Polygon, Wemix) |

**cXAUC / cXAUT** are **M1** eMoney with gold exposure for FX triangulation — **not** substitutes for **LiXAU** (M00 gold reserve index).

### M1 transport (c\* → cW\*)

```text
Off-chain GRU reserves → c* native on Chain 138 → hub c* locked (CWMultiTokenBridgeL1) → GRU bridge mesh → cW* on public networks
```

Escrow for wrapped supply sits on **138**, not Circle USDC or Tether USDT on the destination chain. **CCIP** applies to defined lanes (WETH9/WETH10, LINK) — not the generic label for all **c\*** → **cW\*** movement.

Operator reference: `docs/04-configuration/CHAIN138_RWA_AND_TRANSPORT_ARCHITECTURE.md` (Proxmox monorepo).



## Kebijakan Cadangan
- Cakupan minimum: ≥ 120% dari nilai GRU yang beredar.
- Tingkatan aset: Primer (XAU via `cXAUC/cXAUT`), sekunder (Li, Pt, REE, ETF sovereign), dinamis (aset terverifikasi yang ditokenisasi).
- Ambang deviasi paritas: ±2.5% memicu MPAP (Protokol Penyesuaian Paritas Moneter).

## Tata Kelola
Beroperasi di bawah Sovereign Hybrid Trust Entity (SHTE) dengan kamar:
- Kamar Kebijakan Moneter (MPC)
- Kamar Audit Cadangan (RAC)
- Kamar Layanan Obligasi (BSC)
- Kamar Teknologi & Buku Besar (TLC)
- Kamar Etika & Kepatuhan (ECC)

## Instrumen Kontrol
| Instrumen | Tujuan | Pemicu |
|------------|---------|---------|
| MPAP | Sesuaikan paritas ke XAU | Drift paritas > 2.5% |
| ACP | Kompresi / pembakaran likuiditas | Kelebihan pasokan > pita target |
| Modulasi Hasil Obligasi | Elastisitas pasokan | Sinyal kecepatan / inflasi |

## Transparansi
- Proof-of-Reserves (PoR) Triwulanan
- Dasbor Cadangan Publik (direncanakan)
- Atestasi transaksi buku besar pintar

## Batas Inflasi
Ekspansi bersih tahunan dibatasi pada 2.75% kecuali override krisis dijalankan oleh suara bulat MPC + RAC.

## Ringkasan
Kerangka kerja menggabungkan penerbitan yang didisiplinkan secara matematis, paritas emas, dan perutean likuiditas multi-lapisan untuk membentuk standar cadangan netral-berdaulat yang dapat diaudit.

---

## Indeks Komposit Li & Kolateral M00 — Referensi

- **LiCRI (Komposit Nilai Nominal):**
  ```
  LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
  ```
  Digunakan untuk pelaporan, benchmarking, dan dasbor.

- **Komposit M00 (Kolateral Didukung Aset):**
  ```
  1 M00 = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
  ```
  Digunakan untuk magnitudo cadangan dan kolateral penerbitan.

Kerangka ini sengaja menggunakan Diamond karena lapisan moneter, kepatuhan, indeks, dan jalur aset harus bisa berevolusi secara terpisah tanpa memecah satu permukaan tata kelola.

*Lihat juga [indeks spesifikasi deterministik](../../../meta/Deterministic_Specifications_Index.md), [referensi cepat paritas kanonis](../../../meta/Canonical_Parity_Quick_Reference.md), dan [status implementasi](../../../meta/Implementation_Status_and_Control_Disclosure.md); serta Glossary dan GRU_Formulas untuk spesifikasi lengkap dan bidang audit.*

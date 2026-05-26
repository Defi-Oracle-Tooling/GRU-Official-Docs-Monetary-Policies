---
title: إطار السياسة النقدية GRU
version: 1.0.2
status: مستقر
last_updated: 2026-05-25
layer: سياسة
checksum: معلق
lang: ar
---
# إطار السياسة النقدية GRU

## نظرة عامة
تؤسس وحدة الاحتياطي العالمية (GRU) نظامًا نقديًا متعدد المستويات مدعومًا بالأصول، يربط جميع السيولة عبر XAU (الذهب) لضمان القيمة الجوهرية والتكافؤ القابل للتدقيق والقابلية للتحويل عبر النطاقات. عمليًا، يتم تثليث جميع معاملات FX عبر XAU مع مرجع على السلسلة في `cXAUC/cXAUT`.

### رسم تخطيطي لدورة الإصدار
![دورة إصدار GRU](/assets/media/issuance_cycle.png)
*الشكل: الاحتياطي → الإصدار → التداول مع حلقة إعادة تدوير السيولة والحفاظ على التغطية.*

## النسب الأساسية
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
المعاملات الديناميكية (x، y) هي أوزان التوزيع المعدلة بالسياسة بين طبقات M0 (المؤسسية) و M1 (التجارية).

## القيمة الاسمية المعيّنة مقابل قيمة الأصول الداعمة
```text
القيمة الاسمية / التكافؤ (الوجه، المحاسبة، التسوية):
1 GRU = 1 XAU
1 M0 GRU = 1 XAU
1 M1 GRU = 1 XAU

قيمة الأصول الداعمة (التغطية على جانب الاحتياطيات):
1 M0 GRU = 1.2 XAU من الأصول الداعمة
1 M00 GRU = 6.0 XAU من الأصول الداعمة
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
لتفادي أي لبس، فإن القيمة الاسمية المعيّنة وقيمة الأصول الداعمة مقيستان مختلفتان. القيمة الاسمية هي الوحدة المستخدمة للتكافؤ والمحاسبة والتسوية وضوابط السياسة. أما قيمة الأصول الداعمة فهي كمية أصول الاحتياطي المطلوبة لدعم تلك الوحدة في طبقة معيّنة. اصطلاحات قديمة مثل `1 XAU GRU = 1.2 XAU` تشير إلى قيمة الأصول الداعمة فقط ولا تغيّر تكافؤ الوجه `1 GRU = 1 XAU`.

LiXAU هو مؤشر احتياطي للذهب. وضمن إطار Li توجد خمسة مكونات متساوية القيمة تشكل المركب التشغيلي:
- `LiXAU` = مؤشر احتياطي الذهب
- `LiPMG` = مؤشر مجموعة المعادن الثمينة
- `LiBMG1` = مؤشر مجموعة المعادن الأساسية
- `LiBMG2` = مؤشر مجموعة مواد البطاريات
- `LiBMG3` = مؤشر مجموعة معادن البناء

## هيكل الطبقات
| الطبقة | الوظيفة | الوصف |
|-------|----------|-------------|
| M00 | الإصدار السيادي | الإنشاء الأساسي المرتبط 1:1 بالاحتياطيات المدققة |
| M0  | الاحتياطي المؤسسي | أداة سيولة على مستوى المصارف والسلطات |
| M1  | التداول التجاري | طبقة النقود الإلكترونية للسوق والتسوية |

تعيين التنفيذ الحالي: أصول `c*` القانونية على Chain 138 هي أدوات GRU في طبقة M1. أصول `cW*` على الشبكات العامة هي تمثيلات نقل معكوسة لنفس طبقة GRU M1 وليست فئة نقدية منفصلة.

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



## سياسة الاحتياطي
- الحد الأدنى للتغطية: ≥ 120٪ من قيمة GRU المتداولة.
- مستويات الأصول: الأساسية (XAU عبر `cXAUC/cXAUT`)، الثانوية (Li، Pt، REE، صناديق الاستثمار المتداولة السيادية)، الديناميكية (الأصول المحققة المرمزة).
- عتبة انحراف التكافؤ: ±2.5٪ تفعل MPAP (بروتوكول تعديل التكافؤ النقدي).

## الحوكمة
تعمل تحت كيان الثقة الهجين السيادي (SHTE) مع الغرف:
- غرفة السياسة النقدية (MPC)
- غرفة تدقيق الاحتياطي (RAC)
- غرفة خدمة السندات (BSC)
- غرفة التكنولوجيا ودفتر الأستاذ (TLC)
- غرفة الأخلاقيات والامتثال (ECC)

## أدوات التحكم
| الأداة | الغرض | المحفز |
|------------|---------|---------|
| MPAP | ضبط التكافؤ إلى XAU | انحراف التكافؤ > 2.5٪ |
| ACP | ضغط / حرق السيولة | فائض العرض > النطاق المستهدف |
| تعديل عائد السندات | مرونة العرض | إشارات السرعة / التضخم |

## الشفافية
- إثبات الاحتياطيات (PoR) ربع سنوي
- لوحة تحكم الاحتياطي العامة (مخطط لها)
- شهادات معاملات دفتر الأستاذ الذكي

## سقف التضخم
التوسع الصافي السنوي محدد بـ 2.75٪ ما لم يتم تنفيذ تجاوز الأزمة بتصويت بالإجماع من MPC + RAC.

## الملخص
يجمع الإطار بين الإصدار المنضبط رياضيًا وتكافؤ الذهب وتوجيه السيولة متعدد الطبقات لتشكيل معيار احتياطي محايد سياديًا قابل للتدقيق.

---

## مؤشرات Li المركبة وضمانات M00 — مرجع

- **LiCRI (المركب ذو القيمة الاسمية):**
  ```
  LiCRI = (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3) / 5
  ```
  يستخدم للتقارير والمقارنة المرجعية ولوحات المعلومات.

- **مركب M00 (الضمانات المدعومة بالأصول):**
  ```
  1 M00 = 1.2 × (LiXAU + LiPMG + LiBMG1 + LiBMG2 + LiBMG3)
  ```
  يستخدم لحجم الاحتياطي وضمانات الإصدار.

يستخدم هذا الإطار معيار Diamond عمدًا حتى تتمكن الطبقات النقدية وطبقات الامتثال والمؤشرات ومسارات الأصول من التطور بشكل منفصل دون كسر سطح حوكمة واحد.

*راجع أيضًا [فهرس المواصفات الحتمية](../../../meta/Deterministic_Specifications_Index.md) و[المرجع السريع للتكافؤ القانوني](../../../meta/Canonical_Parity_Quick_Reference.md) و[حالة التنفيذ](../../../meta/Implementation_Status_and_Control_Disclosure.md)، بالإضافة إلى Glossary و GRU_Formulas للمواصفة الكاملة وحقول التدقيق.*

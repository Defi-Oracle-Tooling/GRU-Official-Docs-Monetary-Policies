---
title: Triangulasi GRU & Penciptaan eMoney
version: 1.0.0
status: stabil
last_updated: 2025-10-24
layer: mekanik
checksum: tertunda
language: Bahasa Indonesia
---
# Kerangka Triangulasi GRU & Penciptaan eMoney

## 1. Konsep
Triangulasi mengonversi aset sumber apa pun → XAU → GRU → aset target, menegakkan integritas dan paritas yang didukung aset.

## 2. Jalur Triangulasi
1. Aset Sumber → penilaian XAU (paritas spot)
2. XAU → konversi GRU (rasio peg 1 XAU GRU = 1.2 XAU)
3. GRU → Aset Target (triangulasi terbalik)

Semua triangulasi GRU melewati XAU terlepas dari kelas tujuan (komoditas, mata uang, sekuritas, lainnya).

### Diagram Aliran Triangulasi
![Aliran Triangulasi](../../media/triangulation_flow.pdf)
*Gambar: Cadangan (M0) → Penerbitan (M1) → Distribusi (M2+) dengan jalur umpan balik instrumen kontrol.*

## 3. Logika Penerbitan Atomik (Protokol 7:10)
Untuk setiap 7 unit input (ekuivalen fiat), 10 unit GRU M1 dicetak.
```
GRU_M1 = (Input × 10) / 7
```
Setelah biaya penukaran (f ≤ 0.045), sisa bersih masuk kembali ke siklus berikutnya.

### Contoh Mikro
| Siklus | Input (€) | GRU Dicetak (€) | Setelah Biaya (€) |
|-------|----------:|---------------:|--------------:|
| 1 | 7.0000 | 10.0000 | 9.5500 |
| 2 | 9.5500 | 13.6429 | 13.0289 |
| 3 | 13.0289 | 18.6128 | 17.7752 |

### Contoh Makro (€100M)
| Siklus | Input (€M) | GRU Dicetak (€M) | Setelah Biaya (€M) |
|-------|-----------:|----------------:|---------------:|
| 1 | 100.0000 | 142.8571 | 136.4286 |
| 2 | 136.4286 | 194.8980 | 186.1276 |
| 3 | 186.1276 | 265.8965 | 253.9312 |

## 4. Fungsi Ekspansi
```
E = I × (10/7) × (1 - f)^n
```
Di mana:
- E = Likuiditas yang diperluas
- I = Input awal
- f = Biaya penukaran per siklus
- n = Jumlah loop atomik (default 3)

## 5. Aturan 40/40/20
Diberikan deposit D:
```
Cadangan Dasar  = 0.40 D
Ekspansi        = 0.40 D (penerbitan atomik)
Stabilisasi     = 0.20 D (buffer volatilitas)
Cakupan Target ≈ 2.5 × Cadangan Dasar
```

## 6. Kepatuhan & Audit
- Setiap loop atomik dicatat di Distributed Sovereign Ledger (DSL)
- Toleransi paritas ±0.05% ditegakkan melalui penyesuaian otomatis
- Biaya dipublikasikan untuk transparansi; jadwal biaya dinamis (f) dapat disesuaikan per kecepatan dan kondisi kemacetan

## 7. Pertimbangan Stabilitas
| Risiko | Mitigasi |
|------|------------|
| Volatilitas di XAU | Reweighting cadangan dinamis (adjunct LiXAU) |
| Manipulasi biaya | Jadwal transparan + tata kelola multi-sig |
| Eksploitasi loop | Batas siklus kontrak pintar (n = 3) |

## 8. Peningkatan Masa Depan (Direncanakan)
- Jumlah siklus atomik adaptif berdasarkan kecepatan cadangan
- Triangulasi multi-jangkar (keranjang XAU/XAG/XPT) dengan kontingensi fallback
- Jaringan redundansi oracle on-chain

## Ringkasan
Sistem triangulasi dan penerbitan atomik menghasilkan ekspansi likuiditas terkontrol yang dijangkar aset dengan stabilitas dan auditabilitas bawaan, membentuk tulang punggung mekanik sirkulasi GRU.

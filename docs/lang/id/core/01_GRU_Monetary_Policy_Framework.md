---
title: Kerangka Kebijakan Moneter GRU
version: 1.0.0
status: stabil
last_updated: 2025-10-24
layer: kebijakan
checksum: tertunda
language: Bahasa Indonesia
---
# Kerangka Kebijakan Moneter GRU

## Ikhtisar
Global Reserve Unit (GRU) menetapkan sistem moneter multi-tingkat yang didukung aset, menambatkan semua likuiditas melalui XAU (emas) untuk memastikan nilai intrinsik, paritas yang dapat diaudit, dan konvertibilitas lintas domain.

### Diagram Siklus Penerbitan
![Siklus Penerbitan GRU](../../media/issuance_cycle.pdf)
*Gambar: Cadangan → Penerbitan → Sirkulasi dengan loop daur ulang likuiditas dan pemeliharaan cakupan.*

## Rasio Inti
```
1 M00 GRU = 5 M0 GRU
1 M00 GRU = 25 M1 GRU
1 M00 GRU = x M0 GRU + y M1 GRU
```
Koefisien dinamis (x, y) adalah bobot distribusi yang disesuaikan kebijakan antara lapisan M0 (institusional) dan M1 (komersial).

## Nilai Nominal & Aset
```
1 XAU GRU = 1.2 XAU
1 M0 GRU = 1.2 XAU GRU
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
LiXAU adalah indeks cadangan hibrida komposit yang digunakan untuk diversifikasi dan penyelarasan ESG.

## Struktur Lapisan
| Lapisan | Fungsi | Deskripsi |
|-------|----------|-------------|
| M00 | Penerbitan Berdaulat | Penciptaan dasar terikat 1:1 dengan cadangan yang diaudit |
| M0  | Cadangan Institusional | Instrumen likuiditas tingkat antarbank & otoritas |
| M1  | Sirkulasi Komersial | Lapisan eMoney pasar & penyelesaian |

## Kebijakan Cadangan
- Cakupan minimum: ≥ 120% dari nilai GRU yang beredar.
- Tingkatan aset: Primer (XAU), sekunder (Li, Pt, REE, ETF sovereign), dinamis (aset terverifikasi yang ditokenisasi).
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

*Lihat Glossary dan GRU_Formulas untuk spesifikasi lengkap dan bidang audit.*

---
title: Kerangka Kebijakan Moneter GRU
version: 1.0.1
status: stabil
last_updated: 2026-03-31
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

## Nilai Nominal yang Ditetapkan vs Nilai Aset Pendukung
```text
Nilai nominal / paritas:
1 GRU = 1 XAU
1 M0 GRU = 1 XAU

Nilai aset pendukung:
1 M0 GRU = 1.2 XAU aset pendukung
1 M00 GRU = 6.0 XAU aset pendukung
1.0 LiXAU = 1.2 / 0.9475^4 XAU
```
Nilai nominal yang ditetapkan adalah unit paritas dan pembukuan. Nilai aset pendukung adalah jumlah aset cadangan yang menopang unit tersebut pada lapisan terkait.
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

*Lihat Glossary dan GRU_Formulas untuk spesifikasi lengkap dan bidang audit.*

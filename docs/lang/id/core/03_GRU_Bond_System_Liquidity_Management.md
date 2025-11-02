---
title: Sistem Obligasi GRU & Manajemen Likuiditas
version: 1.0.0
status: stabil
last_updated: 2025-10-24
layer: instrumen
checksum: tertunda
language: Bahasa Indonesia
---
# Sistem Obligasi GRU & Manajemen Likuiditas

## 1. Ikhtisar
Obligasi hibrida perpetual loop tertutup (seri Li99) menyediakan likuiditas elastis sambil mempertahankan solvabilitas yang didukung cadangan.

## 2. Instrumen
| Kode | Nama | Tujuan | Jangka Waktu | Pembelian Kembali |
|------|------|---------|------|----------|
| Li99PpOsB10 | Obligasi Off-set Perpetual 99 tahun | Counterweight kolateral & stabilisasi | 99 tahun | Siklus 10 tahun |
| Li99PpAvB10 | Obligasi Avail Perpetual 99 tahun | Saluran ekspansi & ketersediaan | 99 tahun | Siklus 10 tahun |

## 3. Contoh Akuisisi (Basis €100M)
Asumsi harga pembelian diskon: 15% (diskon 85%)
```
Nominal = 100M / 0.15 = 666.667M
Alokasi Per Obligasi = 666.667M / 2 ≈ 333.333M
Cakupan per obligasi ≈ 250M
```

## 4. Loop Layanan Segitiga
Layanan obligasi terintegrasi dengan penerbitan atomik & siklus 40/40/20:
- Deposit masuk ke Banker's Assistance
- Tiga loop atomik dieksekusi (n=3)
- Likuiditas bersih ditetapkan untuk cakupan + stabilisasi
- Kupon disalurkan ke penguatan cadangan dan escrow pembelian kembali masa depan

### Diagram Siklus Obligasi
Diagram berikut mengilustrasikan jalur likuiditas loop tertutup untuk obligasi seri Li99 selama horizon kupon dan pembelian kembali 10 tahun:

![Loop Likuiditas Siklus Obligasi](../../media/bond_cycle.pdf)

## 5. Aliran Kupon
| Tahap | Tindakan | Dampak |
|-------|--------|--------|
| Akrual | Kupon terakumulasi | Meningkatkan kapasitas reinvestasi |
| Alokasi | Porsi ke escrow pembelian kembali | Menjamin penyelesaian siklus 10 tahun |
| Rollover | Kelebihan direinvestasi | Memperluas bantalan cadangan / mengurangi volatilitas |

## 6. Logika Stabilitas
| Mekanisme | Fungsi | Hasil |
|-----------|---------|---------|
| Pembelian Diskon | Pengeluaran awal rendah | Leverage cakupan tinggi |
| Reinvestasi Kupon | Penggabungan | Keberlanjutan pendanaan mandiri |
| Protokol Pembelian Kembali | Pensiun pokok | Mempertahankan kepercayaan & solvabilitas |
| Struktur Obligasi Ganda | Pemisahan fungsional | Respons likuiditas yang dapat diprediksi |

## 7. Rasio Kunci
- Pengganda cakupan: ≈ 2.5× cadangan dasar per siklus
- Target efisiensi kupon: ≥ 65% retensi reinvestasi
- Ambang batas pendanaan pembelian kembali: 100% dari pokok yang didiskon pada tahun 10

## 8. Tata Kelola & Pengawasan
- Dikelola oleh Bond Servicing Chamber (BSC)
- Diaudit triwulanan oleh Reserve Audit Chamber (RAC)
- Pemantauan real-time melalui registri obligasi DSL

## 9. Risiko & Mitigasi
| Risiko | Deskripsi | Mitigasi |
|------|-------------|-----------|
| Kinerja kupon di bawah | Kompresi pasar atau yield | Matriks penyesuaian yield adaptif |
| Volatilitas diskon | Drift harga pasar | Jendela harga penerbitan mengikat pre-commit |
| Deplesi escrow | Stres pasar tak terduga | Top-up surplus dinamis melalui tranches stabilisasi |
| Ketidakcocokan jatuh tempo | Slippage siklus | Checkpoint terpaksa kontrak pintar |

## 10. Peningkatan Masa Depan
- Bonding multi-kurva (kupon tranching berdasarkan tingkat kecepatan)
- Saluran kupon terkait ESG (pool ekspansi cadangan hijau)
- Wrapper obligasi sintetik untuk akses institusional sekunder

### Integrasi Kecepatan Berbobot Cakupan (Preview)
Revisi mendatang akan menyelaraskan kecepatan reinvestasi kupon dengan kecepatan berbobot cakupan (v_cov), penskalaan dinamis top-up escrow ketika kecepatan transaksional melunak, mempertahankan kepastian pendanaan pembelian kembali.

## Ringkasan
Obligasi seri Li99 memungkinkan ekspansi likuiditas yang dapat diskalakan dan dapat ditebus sendiri tanpa leverage eksternal, memastikan stabilitas perpetual melalui siklus kupon terstruktur dan mekanik pembelian kembali yang terikat cadangan.

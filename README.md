#final_project_application_pos
## Mini E-Commerce & POS Management

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Aplikasi Mini E-Commerce dan POS Management ini memungkinkan pengguna untuk melakukan pembelian produk secara online serta mengelola inventaris dan transaksi penjualan. Aplikasi ini menggunakan Firebase sebagai backend untuk autentikasi, penyimpanan data, dan notifikasi.

### ✨ Video Demo Application : klik image dibawah ini 
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/sX5HoKCIO7A/0.jpg)](https://www.youtube.com/watch?v=sX5HoKCIO7A)

### ✨ Documentation :

| Registration | Login | Splashscreen | Home | cart/order | payment |
| --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
| ![register](https://github.com/user-attachments/assets/2385f57c-53d7-44de-8440-1482a0575e8e)   | ![login](https://github.com/user-attachments/assets/da7d5f96-9985-4cef-bd96-2e226710d87c)   | ![splash-screen](https://github.com/user-attachments/assets/2b3d918c-d8b6-4abc-8539-7fa3bb5aa006)   | ![home](https://github.com/user-attachments/assets/90d10a89-8fd7-4365-b83d-83e3da8efe95)   | ![cart](https://github.com/user-attachments/assets/4d093409-50d1-4353-91f9-db0ab0b1dd92)   | ![payment](https://github.com/user-attachments/assets/9d0d021e-0432-40b5-9783-66c807aa16c4)   |
| --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
| status | convert pdf | Inventory product | drawer | add product | report page |
| --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
| ![status](https://github.com/user-attachments/assets/77a7a918-8551-4f4b-8d9d-b3bd96283fd4)   | ![pdf](https://github.com/user-attachments/assets/7bce35d3-70cf-4ada-8eb9-b30d595c9864)   | ![inventory](https://github.com/user-attachments/assets/c8cd72ce-64ad-4295-887b-7d39cd24c0ec)  | ![drawer](https://github.com/user-attachments/assets/6e8c2cca-8df9-419f-a2ea-89d8de1fe434)   | ![Add product](https://github.com/user-attachments/assets/8aff727b-dabc-44e4-be49-d31505dacb8c)   | ![report](https://github.com/user-attachments/assets/2b35b128-21c0-4182-b8ea-030c04c5dce5)   |
| --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
| My account | alert | notification | firestore | Storage | Authenntication |
| --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
| ![my account](https://github.com/user-attachments/assets/c70e6a67-48ec-4292-b94c-fb8ffe0f6ff6)   | ![alert](https://github.com/user-attachments/assets/247d8aa8-7fea-439d-b228-2698e0148c23)   | ![notification](https://github.com/user-attachments/assets/7f3bea89-bc81-4157-ab66-05aa34663e91)   | ![pos_firebase](https://github.com/user-attachments/assets/b8920e12-c211-42f8-9a4a-dd1feb64f3fe)   | ![storage](https://github.com/user-attachments/assets/97f95ed7-c4c7-4bfe-b891-a5dbef06e11e)   | ![auth](https://github.com/user-attachments/assets/306e05e3-4695-4f5b-99ab-91367497d154)   |
| --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |



## ✨   Features:  
###  1. Authentikasi
- *Login*: Pengguna dapat masuk menggunakan email dan password.
- *Register*: Pendaftaran pengguna baru dengan email, password, nama, dan nomor HP yang disimpan di Firebase Firestore.
- *Auto Login*: Fitur auto-login untuk pengalaman pengguna yang lebih lancar.

###  2. Inventory Management
- Create,read,update,delete, untuk management product
- Stok & Low-Stock Alerts: Menampilkan stok produk dan memberikan peringatan jika stok rendah.
- API: Menggunakan Firestore dan Storage untuk penyimpanan data.
###  3. cart/order
- Data Produk: Mengirim data produk ke halaman keranjang (cart) atau checkout.
- Update Jumlah & Harga: Menambah atau mengurangi jumlah produk, serta memperbarui harga total.
- [x](terlewat) Pembatalan Pesanan: Button untuk membatalkan pesanan.
- Pembayaran: melanjutkan ke halaman pembayaran.
- Local Notification: Notifikasi lokal jika data berhasil ditambahkan ke order.
- API: Menggunakan Firestore untuk penyimpanan data.
###  4. Payment Page
- Metode Pembayaran: Menyediakan opsi pembayaran seperti OVO, GoPay, e-wallet lainnya, serta bank transfer (BRI, BCA, Mandiri).
- Arahkan ke Status Page: Button untuk melanjutkan ke halaman status setelah pembayaran selesai.
- Data pembayaran disimpan di Firestore sebagai data dummy.
###  5. Status Page
- Status Pembayaran: Menampilkan status sukses atau gagal dari pembayaran.
- Data Pembayaran: Menampilkan data dari pembayaran.
- Konversi ke PDF: mengonversi data pembayaran ke dalam format PDF dengan rincian order.
###  6. report page
- Terdapat halaman laporan perihal item apa saja yang telah terjual. Mencakup paling tidak ID order, ID products, kuantitas products, harga tiap product, harga total, metode pembayaran, dan tanggal transaksi. 
- [x] 
- 






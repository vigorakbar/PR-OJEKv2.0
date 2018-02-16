# Tugas 2 IF3110 Pengembangan Aplikasi Berbasis Web

Melakukan *upgrade* Website ojek online sederhana pada Tugas 1 dengan mengaplikasikan **arsitektur web service REST dan SOAP**.

## Tujuan Pembuatan Tugas

Diharapkan dengan tugas ini anda dapat mengerti:
* Produce dan Consume REST API
* Mengimplementasikan service Single Sign-On (SSO) sederhana
* Produce dan Consume Web Services dengan protokol SOAP
* Membuat web application dengan menggunakan JSP yang akan memanggil web services dengan SOAP (dengan JAX-WS) dan REST (dengan Servlet).

## Anggota Tim

1. Vigor Akbar 13515031
2. Rizky Faramita 13515055
3. Turfa Auliarachman 13515133

## Petunjuk Pengerjaan

1. Buatlah organisasi pada gitlab dengan format "IF3110-2017-KXX-nama kelompok", dengan XX adalah nomor kelas.
2. Tambahkan anggota tim pada organisasi anda.
3. Fork pada repository ini dengan organisasi yang telah dibuat.
4. Ubah hak akses repository hasil Fork anda menjadi **private**.
5. [DELIVERABLE] Buat tugas sesuai spesifikasi dan silakan commit pada repository anda (hasil fork). Lakukan berberapa commit dengan pesan yang bermakna, contoh: `add register form`, `fix logout bug`, jangan seperti `final`, `benerin dikit`. Disarankan untuk tidak melakukan commit dengan perubahan yang besar karena akan mempengaruhi penilaian (contoh: hanya melakukan satu commit kemudian dikumpulkan). Sebaiknya commit dilakukan setiap ada penambahan fitur. **Commit dari setiap anggota tim akan mempengaruhi penilaian individu.** Jadi, setiap anggota tim harus melakukan sejumlah commit yang berpengaruh terhadap proses pembuatan aplikasi.
6. Hapus bagian yang tidak perlu dari *readme* ini.
7. [DELIVERABLE] Berikan penjelasan mengenai hal di bawah ini pada bagian **Penjelasan** dari *readme* repository git Anda:
    - Basis data dari sistem yang Anda buat.
    - Konsep *shared session* dengan menggunakan REST.
    - Pembangkitan token dan expire time pada sistem yang anda buat.
    - Kelebihan dan kelemahan dari arsitektur aplikasi tugas ini, dibandingkan dengan aplikasi monolitik (login, CRUD DB, dll jadi dalam satu aplikasi)
8. Pada *readme* terdapat penjelasan mengenai pembagian tugas masing-masing anggota (lihat formatnya pada bagian **pembagian tugas**).
9. Merge request dari repository anda ke repository ini dengan format **Nama kelompok** - **NIM terkecil** - **Nama Lengkap dengan NIM terkecil** sebelum **8 November 2017 23.59**.

### Arsitektur Umum Server
![Gambar Arsitektur Umum](arsitektur_umum.png)

Tugas 2 ini terdiri dari berberapa komponen yang harus dibuat:
* `Web app`: digunakan untuk menangani HTTP request dari web browser dan menghasilkan HTTP response. Bagian yang diimplementasi dengan JSP ini juga bertugas untuk meng-generate tampilan web layaknya PHP. Bagian ini wajib dibuat dengan **Java + Java Server Pages**. Maka dari itu, konversi seluruh kode PHP pada tugas 1 menjadi kode JSP.
* `Ojek Online Web Service`: digunakan sebagai interface yang dipanggil oleh aplikasi melalui protokol SOAP. melakukan query ke database, operasi insert, dan operasi update untuk entitas User, History, dan Preferred Locations. Webservice ini akan dipanggil oleh aplikasi dengan menggunakan SOAP. Webservice ini wajib dibuat dengan **JAX-WS dengan protokol SOAP atau Webservice lain** yang basisnya menggunakan **SOAP dan Java**.
* `Identity service`: dipanggil oleh aplikasi untuk menerima email (sebagai username) dan password pengguna, dan menghasilkan *access token*. Identity Service juga dipanggil oleh *ojek online web service* untuk melakukan validasi terhadap *access token* yang sedang dipegang oleh *web app*. Service ini dibuat menggunakan REST. Namun, selain menghandle request secara REST biasa, Identity Service juga harus bisa **menerima SOAP request dan mengembalikan SOAP response** (contoh SOAP request dan response dapat dilihat pada [link berikut](https://www.tutorialspoint.com/soap/soap_examples.htm)). Identity service ini wajib dibuat dengan menggunakan **Java Servlet**.
* `Database`: pisahkan basis data yang telah Anda buat pada tugas 1 menjadi basis data khusus manajemen *account* (menyimpan username, password, dkk) dan basis data ojek online tanpa manajemen *account*. Basis data *account* digunakan secara khusus oleh Identity Service. **Ojek Online Web Service tidak boleh secara langsung mengakses basis data account untuk melakukan validasi token** (harus melalui Identity Service).

### Deskripsi Tugas

Anda diminta untuk membuat ojek online sederhana seperti tugas 1. Kebutuhan fungsional dan non-fungsional tugas yang harus dibuat adalah sebagai berikut.

1. Halaman website yang memiliki tampilan serupa dengan tugas 1.
2. Ojek Online web service dengan fungsi-fungsi sesuai kebutuhan sistem dalam mengakses data (kecuali login, register, dan logout).
3. Identity service yang menangani manajemen *account* seperti login dan register, serta validasi access token.
4. Fitur validasi email dan username pada halaman register tidak perlu diimplementasikan dengan menggunakan AJAX.
5. Tidak perlu melakukan validasi javascript.
6. Tampilan pada tugas ini **tidak akan dinilai**. Sangat disarankan untuk menggunakan asset dan tampilan dari tugas sebelumnya. Boleh menggunakan CSS framework seperti Bootstrap atau javascript library seperti jQuery.
7. Tidak perlu memperhatikan aspek keamanan dan etika penyimpanan data.

### Skenario

#### Login
1. Pengguna mengakses halaman login, contoh: `/login.jsp` dan mengisi form.
2. JSP akan membuka HTTP request ke Identity Service, contoh `POST /login` dengan body data email dan password.
3. Identity service akan melakukan query ke DB untuk mengetahui apakah email dan password tersebut valid.
4. Identity service akan memberikan HTTP response `access token` dan `expiry time` jika email dan password ada di dalam DB, atau error jika tidak ditemukan data. Silakan definisikan `expiry time` yang menurut Anda sesuai.
5. Access token ini digunakan sebagai representasi state dari session pengguna dan harus dikirimkan ketika pengguna ingin melakukan semua aktivitas, kecuali login, register, dan logout. 
6. Access token dibangkitkan secara random. Silakan definisikan sendiri panjang tokennya.
7. Cara penyimpanan access token dibebaskan.
8. Silakan definisikan format request dan response sesuai kebutuhan anda. Anda dapat menggunakan JSON atau XML untuk REST.

#### Register
1. Pengguna mengakses halaman register, contoh: `/register.jsp` dan mengisi form.
2. JSP akan melakukan HTTP request ke Identity Service, contoh `POST /register` dengan body data yang dibutuhkan untuk registrasi.
3. Identity service akan query DB untuk melakukan validasi bahwa email dan username belum pernah terdaftar sebelumnya.
4. Identity service akan menambahkan user ke DB bila validasi berhasil, atau memberi HTTP response error jika username sudah ada atau confirm password salah.
5. Identity service akan memberikan HTTP response `access token` dan `expiry time` dan user akan ter-login ke halaman profile bila user merupakan driver atau ke halaman order bila user bukan merupakan driver.
6. Silakan definisikan format request dan response sesuai kebutuhan anda. Anda dapat menggunakan JSON atau XML untuk REST.

#### Logout
1. Pengguna menekan tombol logout.
2. JSP akan melakukan HTTP request ke Identity Service, contoh `POST /logout` dengan body data yang dibutuhkan.
3. Identity service akan menghapus atau melakukan invalidasi terhadap access token yang diberikan.
4. Identity service akan mengembalikan HTTP response berhasil.
5. Halaman di-*redirect* ke halaman login.

#### Add Preferred Location, Make an Order, dll
1. Pengguna mengakses halaman add preferred location, misal `/add-preferred-location.jsp` dan mengisi form.
2. JSP akan memanggil fungsi pada *ojek online web service* dengan SOAP, misalnya `addPreferredLocation(access_token, location)`. Contohnya, dapat dilihat pada
[link berikut](http://www.mkyong.com/webservices/jax-ws/jax-ws-hello-world-example/)
Perhatikan pemanggilan pada contoh ini seperti melakukan remote procedure call.
3. Fungsi tersebut akan melakukan HTTP request ke Identity Service, untuk mengenali user dengan `access_token` yang diberikan.
    - Jika `access_token` **kadaluarsa**, maka `addPreferredLocation` akan memberikan response expired token.
    - Jika `access_token` **tidak valid**, maka `addPreferredLocation` akan memberikan response error ke JSP.
    - Jika `access_token` **valid**, maka `addPreferredLocation` akan memasukan produk ke DB, dan memberikan response kesuksesan ke JSP.
4. Jika `access_token` sudah kadaluarsa atau tidak valid (yang diketahui dari response error ojek online web service), sistem akan me-redirect user ke halaman login.
5. Untuk make an order, get history, dan lainnya kira-kira memiliki mekanisme yang sama dengan add preferred locations di atas.
6. Silakan definisikan format object request dan response sesuai kebutuhan anda.

#### Prosedur Demo
Sebelum demo, asisten akan melakukan checkout ke hash commit terakhir yang dilakukan sebelum deadline. Hal ini digunakan untuk memastikan kode yang akan didemokan adalah kode yang terakhir disubmit sebelum deadline.

#### Bonus
- Mekanisme *auto-renew* access token yang tepat sehingga user tidak ter-logout secara paksa saat melakukan serangkaian aktivitas pada sistem dalam waktu yang cukup lama. Access token dapat di generate kembali ketika lifetime dari token tersebut habis. Cara implementasi dibebaskan.

### Penjelasan

#### Basis data dari sistem yang Anda buat.
Secara garis besar, basis data pada sistem ini terbagi menjadi dua yaitu basis data untuk identity_service dan untuk ojek_service. Basis data dari server identity_service memiliki dua buah relasi yakni users dan users_token. Tabel users menyimpan informasi pada users dengan kolom sebagai berikut: ID, name, username, email, phone_number, driver, dan image. ID dan driver bertipe integer. Atribut ID bersifat auto increment sedangkan untuk atribut driver bernilai 1 apabila user adalah driver dan 0 apabila sebaliknya.
Selain kedua atribut tersebut, atribut lainnya bertipe string. Basis data pada ojek_service memiliki dua buah relasi yaitu orders yang terdiri dari destination, driver_id, id, is_complete, is_visible_by_driver, is_visible_by_user, pickingpoint, timestamp, dan user_id serta relasi preferred_locations yang memiliki atribut driver_id, id, dan location.

#### Konsep *shared session* dengan menggunakan REST.
Dengan shared session, server dapat melayani client manapun dan kapan pun. Server tidak terikat pada session tertentu. Server juga tidak akan menyimpan state untuk client session, data tersebut akan disimpan pada client side dan akan dikirimkan ke manapun entitas yang membutuhkan informasi mengenai state dari client session. Sehingga hanya pada kasus tertentu saja server akan menerima client session, bukan setiap kali client mengirimkan request kepada server. 

#### Pembangkitan token dan expire time pada sistem yang anda buat.
Pembangkitan token dilakukan setiap kali user berhasil melewati laman login atau register. Token digenerate secara random dengan menggunakan fungsi generateRandomString() pada Token.java. Waktu sebelum token expired adalah 3600 000 ms atau 1 jam. Token hanya dapat di refresh apabila waktu saat sistem merefresh token tersebut tidak melebihi waktu expiry token tersebut. Fitur ini diatur oleh RefreshToken.java dan dipanggil melalui WebApplication.

#### Kelebihan dan kelemahan dari arsitektur aplikasi tugas ini, dibandingkan dengan aplikasi monolitik (login, CRUD DB, dll jadi dalam satu aplikasi)

Kelebihan:
1. Dapat digunakan oleh service/aplikasi lain tanpai perlu melakukan language bindings/shared libraries.
2. Deployment artifact dari service ini bersifat independent
3. Dapat menangani aplikasi yang relatif kompleks dengan membaginya ke dalam tiga buah service.

Kekurangan:
1. Arsitektur basis data yang terbagi menjadi dua. Partisi dari basis data ini membuat proses update mnejadi lebih lama.
2. Proses testing yang relatif kompleks.
3. Proses deploy lebih sulit.

### Pembagian Tugas

REST :
1. Generate token : 13515133
2. Validasi token : 13515055
3. Refresh token : 13515055
4. Login : 13515133
5. Logout : 13515133
6. Register : 13515031
7. Edit Profile : 13515031

SOAP :
1. Validasi token SOAP : 13515133

Web app (JSP) :
1. Halaman Login : 13515031
2. Halaman Sign Up : 13515031
3. Halaman Add Preferred Location : 13515031
4. Halaman Select Destination : 13515055
5. Halaman Select Driver : 13515055
6. Halaman Complete Order : 13515055
7. Halaman My Profile : 13515133
8. Halaman Edit Profile : 13515133
9. Halaman History : 13515133

## About

Asisten IF3110 2017

Ade | Johan | Kristianto | Micky | Michael | Rangga | Raudi | Robert | Sashi 

Dosen : Yudistira Dwi Wardhana | Riza Satria Perdana | Muhammad Zuhri Catur Candra
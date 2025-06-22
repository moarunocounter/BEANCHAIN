## 🛠️ Persyaratan Awal

Pastikan Anda sudah memiliki:
- VPS / Server Linux (disarankan: Ubuntu 22.04 LTS)
- Akses root (atau sudo)
- Koneksi internet yang stabil
- Java 21, Maven, dan Git (akan otomatis diinstal oleh skrip)

---

## 🚀 Langkah Cepat Instalasi 

### 1. Unduh Skrip Setup

```bash
wget <LINK_TO_beanchain-setup-v3-default-key.sh>
chmod +x beanchain-setup-v3-default-key.sh
```

Gantilah `<LINK_TO_...>` dengan tautan aktual dari file.

---

### 2. Jalankan Skrip Interaktif

```bash
./beanchain-setup-v3-default-key.sh
```

Anda akan diminta konfirmasi `y/n` untuk setiap langkah, seperti:

- Instalasi Java, Maven, Git
- Konfigurasi Maven agar bisa mengakses GitHub Packages
- Clone repo BeanNode
- Generate kunci privat (Wiz Key)
- Konfigurasi `beanchain.config.properties`
- Build & Jalankan node

---

## 💡 Detail Tiap Langkah

### 🔹 Step 1: Instalasi Alat
- Akan menginstal Java 21, Maven, dan Git
- Kompatibel dengan Linux & macOS

### 🔹 Step 2: Konfigurasi Maven
- Anda akan diminta GitHub Username dan Token (dengan scope `read:packages`)
- Token ini dibutuhkan untuk mengakses dependency `bean-pack`

### 🔹 Step 2.5: Clone Repository
- Clone repo `beannode` dari GitHub

### 🔹 Step 3: Generate Wiz Key
- Jalankan `wiz-suite-v0.jar`
- Gunakan perintah: `DISPLAY`, `WIZ`, `EXIT`
- File `wiz.txt` akan disimpan di `config.docs/`

### 🔹 Step 4: Konfigurasi Node
Anda akan diminta:
- Port jaringan (default: 6442)
- Apakah node ini public (`true`/`false`)
- Path ke private key (default: `./config.docs/wiz.txt`)

### 🔹 Step 5: Build dan Jalankan Node
- Build dengan `mvn clean install`
- Jalankan node:
  ```bash
  java -jar BeanNode-v0.0.2.jar
  ```
- Gunakan `devmode` untuk melihat proses sinkronisasi

---

## ⚙️ Opsional: Setup systemd

Buat agar node berjalan otomatis saat reboot:

1. Pindahkan file:
```bash
sudo mv bean-node.service /etc/systemd/system/
```

2. Jalankan:
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable bean-node
sudo systemctl start bean-node
sudo systemctl status bean-node
```

---

## 🧯 Tips Keamanan

- Backup file `wiz.txt` ke lokasi aman
- Gunakan firewall: hanya buka port `6442` (dan `8080` jika public)
- Gunakan `tmux` atau `screen` untuk monitoring manual
- Pantau dengan `journalctl -u bean-node -f`

---

## 🙌 Selesai!

Node BeanChain Anda sekarang sudah siap beroperasi 🚀  
Selamat bergabung di jaringan!


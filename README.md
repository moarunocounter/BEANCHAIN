![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

# 🫘 BeanChain One-Click Node Setup by MOARU

Skrip ini akan membantu Anda menginstal dan menjalankan node **BeanChain** secara interaktif dan otomatis.  
Semua langkah dilakukan satu per satu dengan konfirmasi langsung, cocok untuk pemula maupun yang berpengalaman.

---

## 📦 Persyaratan

- ✅ Server Linux (direkomendasikan Ubuntu 22.04+)
- ✅ Akses `root` atau `sudo`
- ✅ Koneksi internet stabil
- ❌ Tidak perlu install Java/Maven/Git secara manual — akan dipasang otomatis

---

## 🚀 Cara Menggunakan Skrip

### 1. Unduh dan Jalankan

```bash
wget https://raw.githubusercontent.com/moarunocounter/BEANCHAIN/main/bean.sh -O bean.sh && chmod +x bean.sh && ./bean.sh
```

---

## 🧭 Step-by-Step yang Akan Dijalankan

### 🔹 Step 1: Install Tools
- Java 21
- Maven
- Git
- Otomatis menyesuaikan dengan OS: Ubuntu, Fedora, Arch, macOS

### 🔹 Step 2: Konfigurasi Maven
- Masukkan GitHub username dan token (`read:packages`)
- Token akan disimpan di `~/.m2/settings.xml`

### 🔹 Step 2.5: Clone Repository
- Skrip akan clone repo `beannode` dari GitHub
- Jika sudah ada, akan dilewati

### 🔹 Direktori Otomatis
- Skrip otomatis masuk ke folder `beannode` jika belum di dalamnya

### 🔹 Step 3: Generate Wiz Key
- Jalankan `wiz-suite-v0.jar`
- Ikuti instruksi CLI untuk menghasilkan `wiz.txt`

### 🔹 Step 4: Konfigurasi Node
Anda akan diminta mengisi:
- Port jaringan (default: `6442`)
- Apakah node akan `public` (default: `true`)
- Lokasi private key (`wiz.txt`, default: `./config.docs/wiz.txt`)

### 🔹 Step 5: Build dan Jalankan
- Build otomatis dengan `mvn clean install`
- Node langsung dijalankan via `java -jar`
- Gunakan:
  ```bash
  devmode
  ```
  untuk melihat log sinkronisasi

---

## 🛡️ Tips & Saran

- 💾 Backup `wiz.txt` ke tempat aman
- 🔥 Buka port 6442 di firewall Anda jika public node
- 🛠️ Jalankan ulang node dengan:
  ```bash
  java -jar BeanNode-*.jar
  ```

---

## 🎉 Selesai!

Jika Anda melihat log sinkronisasi atau koneksi ke bootstrap node, maka node Anda sudah berjalan dengan baik!

---

Dibuat oleh: **Moaru**  
🔗 Script ini bebas digunakan untuk komunitas BeanChain dan pembelajaran pribadi.

📖 [Official Node Setup Guide](https://github.com/BeanChain-Core/docs/blob/main/EARLY-NODE-GUIDE.md)


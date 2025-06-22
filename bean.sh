set -e

function prompt_step() {
    echo ""
    read -p "==> Jalankan langkah ini? [y/n] " yn
    case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        *) echo "Pilih y atau n."; prompt_step ;;
    esac
}

echo " _________________________________________"
echo "|                                         |"
echo "| BEANCHAIN ONE-CLICK SETUP NODE by MOARU |"
echo "|_________________________________________|"
echo ""
echo "Follow step by step sesuai arahan."

echo ""
echo "Step 1: Install Tools yang dibutuhkan (Java 21, Maven, Git)"
if prompt_step; then
    OS="$(uname -s)"
    if [[ "$OS" == "Darwin" ]]; then
        echo "macOS terdeteksi. Menggunakan Homebrew..."
        brew install openjdk@21 maven git
    elif [[ "$OS" == "Linux" ]]; then
        echo "Linux terdeteksi."
        if command -v apt >/dev/null; then
            sudo apt update
            sudo apt install -y openjdk-21-jdk maven git
        elif command -v dnf >/dev/null; then
            sudo dnf install -y java-21-openjdk maven git
        elif command -v pacman >/dev/null; then
            sudo pacman -Syu --noconfirm jdk-openjdk maven git
        else
            echo "Package manager tidak dikenali. Install manual: Java 21, Maven, Git."
        fi
    else
        echo "OS tidak didukung oleh skrip ini."
    fi
    echo "Versi yang terpasang:"
    java -version
    mvn -version
    git --version
fi

echo ""
echo "Step 2: Configure Maven to Access bean-pack"
if prompt_step; then
    SETTINGS_FILE="$HOME/.m2/settings.xml"
    echo "Silakan buat Personal Access Token GitHub dengan scope read:packages"
    read -p "Masukkan GitHub Username: " GH_USER
    read -p "Masukkan GitHub Token: " GH_TOKEN
    mkdir -p ~/.m2
    cat > "$SETTINGS_FILE" <<EOF
<settings>
  <servers>
    <server>
      <id>github</id>
      <username>${GH_USER}</username>
      <password>${GH_TOKEN}</password>
    </server>
  </servers>
</settings>
EOF
    echo "✅ settings.xml tersimpan di $SETTINGS_FILE"
fi

echo ""
echo "Step 2.5: Clone BeanNode Repository"
if prompt_step; then
    if [[ -d beannode ]]; then
        echo "Direktori 'beannode' sudah ada. Lewati clone."
    else
        git clone https://github.com/beanchain-core/beannode.git
    fi
fi

if [[ "$(basename "$PWD")" != "beannode" && -d beannode && -f beannode/config.docs/beanchain.config.properties ]]; then
    echo "📁 Masuk ke direktori 'beannode'..."
    cd beannode
fi

echo ""
echo "Step 3: Generate Wiz Key"
if prompt_step; then
    echo "Pastikan file wiz-suite-v0.jar berada di direktori saat ini."
    java -jar wiz-suite-v0.jar
fi

echo ""
echo "Step 4: Konfigurasi Node Kamu"
if prompt_step; then
    CONFIG_FILE="config.docs/beanchain.config.properties"
    echo "Edit konfigurasi default:"
    read -p "Port jaringan [default 6442]: " PORT
    read -p "Public node? (true/false) [default true]: " PUB
    read -p "Path ke private key (wiz.txt) [default ./config.docs/wiz.txt]: " PKEY

    PORT=${PORT:-6442}
    PUB=${PUB:-true}
    PKEY=${PKEY:-./config.docs/wiz.txt}

    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "❌ File konfigurasi tidak ditemukan: $CONFIG_FILE"
        exit 1
    fi

    sed -i.bak -e "s/^networkport=.*/networkport=${PORT}/" \
               -e "s/^is.public=.*/is.public=${PUB}/" \
               -e "s|^privateKeyPath=.*|privateKeyPath=${PKEY}|" "$CONFIG_FILE"
    echo "✅ Konfigurasi berhasil diperbarui."
fi

echo ""
echo "Step 5: Build dan Jalankan Node"
if prompt_step; then
    mvn clean install
    JAR_NAME=$(ls target/BeanNode-*.jar | head -n1)
    mv "$JAR_NAME" . || true
    echo "Menjalankan node..."
    java -jar $(basename "$JAR_NAME")
    echo "ℹ️ Gunakan perintah 'devmode' untuk melihat log sinkronisasi"
    echo "ℹ️ Gunakan perintah 'help' untuk melihat daftar CLI command"
fi

echo ""
echo "🎉 Setup selesai. BeanChain Node sudah dijalankan!"
echo ""
echo "✅ Jika ingin jalankan ulang node:"
echo "   java -jar $(basename "$JAR_NAME")"
echo ""
echo "📌 Pastikan port 6442 dibuka jika public node."

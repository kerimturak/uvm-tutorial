#!/bin/bash
# ============================================================
# Sıfırdan Kurulum (temiz makine için)
# Zaten kuruluysa çalıştırmana gerek yok!
# ============================================================
set -e

echo "=== 1/3: Sistem paketleri ==="
sudo apt update -y
sudo apt install -y git make g++ perl python3 bison flex libfl-dev help2man z3 autoconf wget

echo ""
echo "=== 2/3: Verilator ==="
TOOLS="/home/kerim/tools"
mkdir -p "$TOOLS"

if [ -f "$TOOLS/verilator/bin/verilator" ]; then
    echo "Verilator zaten kurulu, atlanıyor."
else
    git clone https://github.com/verilator/verilator "$TOOLS/verilator"
    cd "$TOOLS/verilator"
    autoconf && ./configure && make -j "$(nproc)"
    cd -
fi

echo ""
echo "=== 3/3: UVM ==="
if [ -f "$TOOLS/uvm-2017/uvm_pkg.sv" ]; then
    echo "UVM zaten kurulu, atlanıyor."
else
    # Workspace'teki yerel kopya varsa linkle
    if [ -f "/home/kerim/uvm/1800.2-2017-1.0/src/uvm_pkg.sv" ]; then
        ln -sf /home/kerim/uvm/1800.2-2017-1.0/src "$TOOLS/uvm-2017"
        echo "UVM yerel kopyadan linklendi."
    else
        echo "UVM bulunamadı. 1800.2-2017-1.0 klasörünü indirmeniz gerekiyor."
        exit 1
    fi
fi

echo ""
echo "=== Kurulum tamam! ==="
echo "Şimdi çalıştır:  source env.sh"

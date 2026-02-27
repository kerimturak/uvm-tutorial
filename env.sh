#!/bin/bash
# Ortam değişkenlerini ayarla — her terminalde bir kez çalıştır:
#   source env.sh

export PATH="/home/kerim/tools/verilator/bin:$PATH"
export UVM_HOME="/home/kerim/tools/uvm-2017"

echo "Verilator : $(verilator --version 2>/dev/null || echo 'BULUNAMADI')"
echo "UVM_HOME  : $UVM_HOME"

# QuestaSim için Makefile
# Bu Makefile, RTL ve UVM testbenchlerini derleyip simüle etmek için kullanılacaktır.

VSIM   = vsim
VLOG   = vlog
VLIB   = vlib
VMAP   = vmap
PYTHON = python  # Python 3 için 'python' (Windows'ta olabilir)

# Klasör Tanımlamaları
RTL_DIR = ../rtl
TB_DIR = ../tb
UVM_DIR = ../uvm
SCRIPT_DIR = ../script
WORK_DIR = work

# Include Dizinleri
INCDIR = +incdir+$(RTL_DIR) +incdir+$(UVM_DIR) +incdir+$(TB_DIR)

# Dosya Listeleri (.f dosyalarından alınıyor)
RTL_F = $(SCRIPT_DIR)/rtl.f
TB_F = $(SCRIPT_DIR)/tb.f
TOP_MODULE = top

# Flagler
VLOG_FLAGS = -sv $(INCDIR) -svinputport=relaxed
VSIM_FLAGS =  -uvmcontrol=all -voptargs="+acc" -assertdebug -debugDB=+all -work $(WORK_DIR)

# Varsayılan hedef
all: clean compile simulate

# Çalışma Kütüphanesini Oluştur
lib:
	$(VLIB) $(WORK_DIR)

# RTL ve Testbench Dosyalarını Derle
compile: lib
	$(VLOG) $(VLOG_FLAGS) -work $(WORK_DIR) -f $(RTL_F) -f $(TB_F)

# Simülasyonu Çalıştır
simulate: compile
	$(VSIM) $(VSIM_FLAGS) work.$(TOP_MODULE) -do "run -all; quit"

# Temizlik İşlemi
clean:
	rm -rf $(WORK_DIR) transcript vsim.wlf

.PHONY: all lib compile simulate clean
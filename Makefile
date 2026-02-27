# =============================================================================
# Master Makefile — UVM + Verilator Eğitim Ortamı
# =============================================================================
# Kullanım:
#   make                    → yardım göster
#   make sim P=cache        → bir projeyi derle+çalıştır
#   make compile P=cache    → sadece derle
#   make clean              → hepsini temizle
# =============================================================================

UVM_HOME ?= /home/kerim/tools/uvm-2017
export UVM_HOME

# Makefile içeren klasörleri bul (setup/ hariç)
PROJECTS := $(filter-out setup, $(patsubst %/Makefile,%,$(wildcard */Makefile)))

.PHONY: help list verify compile run sim clean

.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "=== UVM + Verilator Eğitim Ortamı ==="
	@echo ""
	@echo "Projeler:"
	@for p in $(PROJECTS); do echo "  $$p"; done
	@echo ""
	@echo "Komutlar:"
	@echo "  make sim P=antmicro-example   Derle + çalıştır"
	@echo "  make compile P=cache          Sadece derle"
	@echo "  make run P=cache              Sadece çalıştır"
	@echo "  make clean                    Hepsini temizle"
	@echo "  make verify                   Kurulum kontrolü"
	@echo ""

verify:
	@echo -n "Verilator: " && verilator --version 2>/dev/null || echo "BULUNAMADI"
	@test -f $(UVM_HOME)/uvm_pkg.sv && echo "UVM: $(UVM_HOME)" || echo "UVM: BULUNAMADI"

list:
	@for p in $(PROJECTS); do echo "$$p"; done

compile:
	@test -n "$(P)" || { echo "Proje belirt: make compile P=cache"; exit 1; }
	$(MAKE) -C $(P) compile

run:
	@test -n "$(P)" || { echo "Proje belirt: make run P=cache"; exit 1; }
	$(MAKE) -C $(P) run

sim:
	@test -n "$(P)" || { echo "Proje belirt: make sim P=cache"; exit 1; }
	$(MAKE) -C $(P) sim

clean:
	@for p in $(PROJECTS); do echo "Temizleniyor: $$p"; $(MAKE) -s -C $$p clean 2>/dev/null || true; done
	@echo "Temiz."

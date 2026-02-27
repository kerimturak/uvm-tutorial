# UVM Proje Şablonu — Makefile
# make sim → derle + çalıştır

TOP_MODULE  = tb
TEST_NAME  ?= test_simple
UVM_HOME   ?= /home/kerim/tools/uvm-2017
FLIST       = flist.txt

VFLAGS = --binary -j $$(nproc) --timescale 1ns/1ps --trace \
         -Wno-fatal +define+UVM_NO_DPI -I$(UVM_HOME) \
         --top-module $(TOP_MODULE)
BIN    = obj_dir/V$(TOP_MODULE)
SRC    = $(shell grep -v '^\s*\#' $(FLIST) | grep -v '^\s*$$')

.PHONY: compile run sim clean

sim: compile run

compile:
	@echo "--- Derleniyor ---"
	verilator $(VFLAGS) $(UVM_HOME)/uvm_pkg.sv $(SRC)

run:
	@test -f $(BIN) || { echo "Önce: make compile"; exit 1; }
	./$(BIN) +UVM_TESTNAME=$(TEST_NAME) +UVM_VERBOSITY=UVM_MEDIUM

clean:
	rm -rf obj_dir *.vcd *.log

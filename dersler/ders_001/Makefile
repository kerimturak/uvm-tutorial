# SV OOP Temelleri — Makefile (UVM yok)
# make sim → derle + çalıştır

TOP_MODULE = tb
FLIST      = flist.f

SRC = $(shell grep -v '^\s*\#' $(FLIST) | grep -v '^\s*$$')
BIN = obj_dir/V$(TOP_MODULE)

.PHONY: compile run sim clean

sim: compile run

compile:
	@echo "--- Derleniyor ---"
	verilator --binary -j $$(nproc) --timescale 1ns/1ps --trace \
	  -Wno-fatal --top-module $(TOP_MODULE) $(SRC)

run:
	@test -f $(BIN) || { echo "Önce: make compile"; exit 1; }
	./$(BIN)

clean:
	rm -rf obj_dir *.vcd *.log

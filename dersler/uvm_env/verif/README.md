Verification tree for ders_003 stack DUT

Structure created:
- verif/sv/interfaces/    : interfaces for DUT
- verif/sv/uvc/          : UVC components (seq_item, driver, monitor, seqr, agent)
- verif/tb/env/          : UVM environment, scoreboard, cfg
- verif/tb/sequences/    : test sequences
- verif/tb/tests/        : test top-level class files

Edit `verif/Flist.stack_tb` to list real files in compilation order.
Use `make SIM=vcs sim` to compile/run (requires VCS).
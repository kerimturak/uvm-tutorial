# Ders 009 - DUT Baglantisi ve Verification Component Kurulumu

## Turkce

Bu ders, PDF'deki `Connection to a DUT` ve `Building a Verification Component` basliklarini repo icindeki en olgun ornekle birlestiriyor.

- Testbench top modulu, clock/reset uretimi, interface instance'i, DUT instance'i ve environment nesnesini ayni yerde bir araya getiriyor.
- `spmp_stack_if`, DUT sinyallerini tek bir arabirim altinda toplayarak driver ve monitor tarafini sadeleştiriyor.
- `spmp_pkg`, packet, component base, sequencer, driver, monitor, agent ve env siniflarini tek package altinda topluyor.
- `env.configure(stack_if);` cagrisi ile virtual interface referanslari verification component'lere dagitiliyor.
- `env.run(50);` akisi, monitor'u paralel baslatip driver uzerinden trafik uretiyor.

### Onemli Notlar

- Driver ve monitor'un interface'e `virtual interface` ile baglanmasi, class tabanli verification ile RTL sinyalleri arasindaki kopruyu kurar.
- Agent, ilgili verification rollerini ayni noktada toplar; env ise daha ust seviye orkestrasyonu yapar.
- Package tabanli organizasyon, dosya sirasi ve include yonetimini daha kontrollu hale getirir.
- Bu ders tam UVM kullanmiyor, fakat UVM dusunce yapisina oldukca yakin bir yapi kuruyor.

### Bu Klasorde Ne Var

- `rtl/`: referans stack DUT
- `verif/`: interface, package, UVC siniflari ve testbench top
- `flist.f`: derleme sirasini tanimlayan dosya listesi
- `Makefile`: `make sim` ile derleme ve calistirma akisi

## English

This lesson combines the PDF themes `Connection to a DUT` and `Building a Verification Component` in the most mature example in the repository.

- The testbench top module brings clock/reset generation, the interface instance, the DUT instance, and the environment object into one place.
- `spmp_stack_if` collects the DUT signals under a single interface and simplifies the driver and monitor side.
- `spmp_pkg` groups packet, component base, sequencer, driver, monitor, agent, and env classes into one package.
- The call `env.configure(stack_if);` distributes virtual-interface references to the verification components.
- The `env.run(50);` flow starts the monitor in parallel and generates traffic through the driver.

### Key Notes

- Connecting driver and monitor to the interface through a `virtual interface` creates the bridge between class-based verification and RTL signals.
- The agent gathers related verification roles together, while the env performs higher-level orchestration.
- Package-based organization gives tighter control over file order and include management.
- This lesson does not use full UVM, but it builds a structure that is very close to the UVM way of thinking.

### Files In This Folder

- `rtl/`: reference stack DUT
- `verif/`: interface, package, UVC classes, and testbench top
- `flist.f`: file list that defines compile order
- `Makefile`: build-and-run flow with `make sim`
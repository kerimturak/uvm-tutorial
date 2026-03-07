# Verification Yapisi

## Turkce

Bu klasor, ders 009'un verification tarafini tutar.

- `sv/interfaces/spmp_stack_if.sv`: DUT portlarini class tarafindan erisilebilir hale getiren interface
- `sv/spmp_pkg.sv`: verification class dosyalarini package altinda toplayan giris noktasi
- `sv/uvc/packet.sv`: randomize edilen veri nesnesi
- `sv/uvc/sequencer.sv`: packet ureten sinif
- `sv/uvc/driver.sv`: packet'i sinyal gecislerine cevirip interface uzerinden DUT'a suren sinif
- `sv/uvc/monitor.sv`: interface'teki sinyalleri okuyup tekrar packet benzeri veri haline getiren sinif
- `sv/uvc/agent.sv`: sequencer, driver ve monitor'u ayni component altinda toplar
- `sv/uvc/env.sv`: configure ve run akislarini yoneten ust seviye verification component
- `spmp_stack_tb_top.sv`: top module, DUT ve env baglantisi

### Onemli Notlar

- Derleme sirasinda interface ve package dosyalari top modolden once hazir olmalidir.
- Driver ile monitor, ayni interface'e bakarak stimulus ve gozlem taraflarini ayirir.
- `component_base` kullanimi, hiyerarsik isim ve parent yapisini korur.

## English

This folder holds the verification side of lesson 009.

- `sv/interfaces/spmp_stack_if.sv`: interface that exposes DUT ports to class-based code
- `sv/spmp_pkg.sv`: entry point that groups verification classes under one package
- `sv/uvc/packet.sv`: randomized data object
- `sv/uvc/sequencer.sv`: class that creates packets
- `sv/uvc/driver.sv`: class that converts packets into signal activity and drives the DUT through the interface
- `sv/uvc/monitor.sv`: class that observes interface signals and reconstructs packet-like data
- `sv/uvc/agent.sv`: collects sequencer, driver, and monitor under one component
- `sv/uvc/env.sv`: top-level verification component that manages configure and run flows
- `spmp_stack_tb_top.sv`: top module that connects the DUT and the environment

### Key Notes

- During compilation, the interface and package files must be available before the top module uses them.
- Driver and monitor look at the same interface while keeping stimulus and observation responsibilities separate.
- Using `component_base` preserves the hierarchical name and parent structure.
# Ders 008 - Component Hiyerarsisi, Parent Pointer ve Pathname

## Turkce

Bu ders, PDF'deki components ve component hierarchy fikrini sade bir UVM-benzeri yapiyla gosteriyor.

- `component_base` sinifi her component icin `name` ve `parent` bilgisini tutuyor.
- `pathname()` method'u parent zincirini takip ederek hiyerarsik isim uretiyor.
- `agent`, kendi altinda `sequencer`, `driver` ve `monitor` nesnelerini olusturuyor.
- `drv.sref = sq;` baglantisi ile component'lerin birbirine referans vererek haberlesebilecegi gosteriliyor.
- Bu yapi, gercek UVM component mimarisine gecmeden once temel zihinsel modeli kuruyor.

### Onemli Notlar

- Her component'in instance name'i ve parent pointer'i olmasi, hiyerarsik gezinmeyi kolaylastirir.
- Component hiyerarsisi aggregate class fikrinin verification'a uyarlanmis halidir.
- Ortak davranislari base class'ta toplamak, component siniflarini sade tutar.
- Driver, monitor ve sequencer gibi rollerin ayrilmasi ileride daha buyuk ortamlara gecisi kolaylastirir.

### Bu Klasorde Ne Var

- `tb.sv`: component base class, agent hiyerarsisi ve pathname ornegi
- `components.drawio`: yapisal diyagram
- `flist.f`: derleme dosya listesi
- `Makefile`: Verilator akisi

## English

This lesson demonstrates the PDF idea of components and component hierarchy with a simplified UVM-like structure.

- The `component_base` class stores `name` and `parent` information for every component.
- The `pathname()` method follows the parent chain to build a hierarchical name.
- The `agent` creates `sequencer`, `driver`, and `monitor` objects below it.
- The connection `drv.sref = sq;` shows that components can communicate by sharing references.
- This structure builds the mental model before moving into a real UVM component architecture.

### Key Notes

- Giving each component an instance name and a parent pointer makes hierarchical navigation much easier.
- A component hierarchy is essentially the aggregate-class idea adapted to verification.
- Keeping common behavior in a base class helps keep component classes small.
- Separating roles such as driver, monitor, and sequencer makes it easier to scale into larger environments later.

### Files In This Folder

- `tb.sv`: component base class, agent hierarchy, and pathname example
- `components.drawio`: structural diagram
- `flist.f`: compile file list
- `Makefile`: Verilator flow
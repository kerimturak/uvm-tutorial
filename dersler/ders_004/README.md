# Ders 004 - Static Property ve Static Method

## Turkce

Bu ders, PDF'deki static properties and methods konusunu repo ornegiyle gosteriyor.

- `instance_count` alani `static` oldugu icin her nesneye ait ayri kopya yerine sinif genelinde tek kopya tutulur.
- Her `new()` cagrisinda sayac artirilir ve olusturulan instance sayisi takip edilir.
- `get_count()` static bir method olarak hem handle uzerinden hem de `stack::get_count()` biciminde class scope ile cagrilabilir.
- Sinifin geri kalan kismi onceki dersteki randomization yapisini korur; bu sayede static kavrami tanidik bir ornek icinde gorulur.

### Onemli Notlar

- Static veri, nesneye degil class'a aittir.
- Static method icinde instance'a ozgu alanlara dogrudan baglanmamak gerekir.
- Instance sayaci gibi ortak bilgi tutmak icin static alanlar cok kullanislidir.
- Class scope ile cagrim, niyetin daha acik gorunmesini saglar.

### Bu Klasorde Ne Var

- `tb.sv`: static sayac, static method ve onceki randomization akisinin birlikte kullanimi
- `flist.f`: derleme dosya listesi
- `Makefile`: Verilator akisi

## English

This lesson demonstrates the PDF topic of static properties and static methods through the repository example.

- The `instance_count` field is `static`, so there is one shared copy for the class instead of one copy per object.
- Each call to `new()` increments the counter and tracks how many instances have been created.
- `get_count()` is a static method, so it can be called through a handle or with class scope as `stack::get_count()`.
- The rest of the class keeps the earlier randomization structure, which makes the static concept easier to see in a familiar example.

### Key Notes

- Static data belongs to the class, not to a specific object.
- A static method should avoid depending directly on instance-specific state.
- Shared information such as instance counters is a natural use case for static fields.
- Calling through class scope makes the intent clearer.

### Files In This Folder

- `tb.sv`: static counter, static method, and the earlier randomization flow in one example
- `flist.f`: compile file list
- `Makefile`: Verilator flow
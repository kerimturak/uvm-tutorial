# Ders 007 - Aggregate Class, Reference Copy ve Deep Clone

## Turkce

Bu ders, PDF'deki aggregate classes konusunu handle tabanli alt nesneler uzerinden anlatiyor.

- `stack` sinifi icinde `rand door d1;` ve `rand door d2;` alanlari bulunuyor; yani bir class, baska class instance'larini property olarak tutabiliyor.
- Alt nesneler handle oldugu icin constructor icinde acikca `new()` ile olusturulmalari gerekiyor.
- Aggregate yapida randomization, yalnizca `rand` olarak isaretlenmis alt property'ler boyunca ilerler.
- `s2 = s1;` gibi atamalar yeni nesne olusturmaz; sadece ayni objeye giden ikinci bir referans uretir.
- `s2 = new s1;` ilk seviyede clone uretir, ancak alt object'ler icin tam bagimsizlik istiyorsak `d1` ve `d2` icin de ayri clone gerekir.

### Onemli Notlar

- Reference copy verification tarafinda gizli bug kaynagi olabilir.
- Shallow clone ilk seviyeyi kopyalar; deep clone tum object hiyerarsisini ayri hale getirir.
- Aggregate class tasariminda encapsulation ve sahiplik iliskisi net dusunulmelidir.
- Instance isimleri, alt nesneleri loglarda ayirt etmeyi kolaylastirir.

### Bu Klasorde Ne Var

- `tb.sv`: aggregate member, reference copy, shallow clone ve deep clone ornegi
- `flist.f`: derleme dosya listesi
- `Makefile`: Verilator akisi

## English

This lesson explains the PDF topic of aggregate classes through handle-based sub-objects.

- The `stack` class contains `rand door d1;` and `rand door d2;`, so one class can hold instances of another class as properties.
- Because those sub-objects are handles, they must be explicitly created with `new()` inside the constructor.
- In an aggregate structure, randomization only descends through sub-properties marked as `rand`.
- Assignments such as `s2 = s1;` do not create a new object; they only create another reference to the same object.
- `s2 = new s1;` creates a first-level clone, but if full independence is required, `d1` and `d2` must also be cloned separately.

### Key Notes

- Reference copies can become a hidden source of bugs in verification code.
- A shallow clone copies only the first level; a deep clone separates the entire object hierarchy.
- In aggregate class design, encapsulation and ownership should be thought through clearly.
- Instance names make it easier to distinguish sub-objects in logs.

### Files In This Folder

- `tb.sv`: aggregate members, reference copy, shallow clone, and deep clone example
- `flist.f`: compile file list
- `Makefile`: Verilator flow
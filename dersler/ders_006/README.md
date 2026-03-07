# Ders 006 - Polymorphism, Virtual Method ve Casting

## Turkce

Bu ders, PDF'deki inheritance and polymorphism akisinin dispatch ve cast tarafina odaklaniyor.

- Base class handle'i, tureyen sinif nesnesini tutabilir: `stack s;` icine `door_stack` instance'i atanabiliyor.
- Base handle uzerinden sadece base class uyeleri gorunur.
- `whoami()` method'u `virtual` oldugu icin cagri handle tipine gore degil, handle'in gosterdigi gercek nesneye gore cozulur.
- `$cast(d_2, s);` ile base handle icindeki turemis nesne tekrar derived handle'a indirgeniyor.

### Onemli Notlar

- Virtual method, polymorphism'in pratikte calistigi ana mekanizmadir.
- Downcast islemi icin `$cast` kullanmak, dogrudan atamaya gore daha guvenlidir.
- Bir method base class'ta virtual ise, override edilen tureyen method da virtual davranisini surdurur.
- Verification kodunda ortak API'yi base class'ta tutup farkli davranislari derived class'lara dagitmak yaygin bir yaklasimdir.

### Bu Klasorde Ne Var

- `tb.sv`: base handle, derived object, virtual dispatch ve `$cast` ornegi
- `flist.f`: derleme dosya listesi
- `Makefile`: Verilator akisi

## English

This lesson focuses on the dispatch and cast side of the PDF's inheritance and polymorphism flow.

- A base-class handle can point to a derived-class object: a `door_stack` instance can be assigned into `stack s;`.
- Through a base handle, only the base-class members are visible.
- Because `whoami()` is `virtual`, the call is resolved by the real object stored in the handle, not just by the handle type.
- `$cast(d_2, s);` downcasts the derived object stored in the base handle back into a derived handle.

### Key Notes

- A virtual method is the main mechanism that makes polymorphism work in practice.
- Using `$cast` for downcasting is safer than relying on direct assignment.
- If a method is virtual in the base class, the overridden method in derived classes keeps that virtual behavior.
- In verification code, it is common to keep a shared API in the base class and distribute different behavior across derived classes.

### Files In This Folder

- `tb.sv`: base handle, derived object, virtual dispatch, and `$cast` example
- `flist.f`: compile file list
- `Makefile`: Verilator flow
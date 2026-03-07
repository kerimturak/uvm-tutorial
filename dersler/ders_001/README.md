# Ders 001 - Temel Sinif, Handle ve Constructor

## Turkce

Bu ders, PDF'deki temel sinif ve nesne mantigini repo icindeki ilk ornekle uyguluyor.

- `stack` sinifi yeni bir veri tipi tanimlar.
- `stack s;` satiri nesnenin kendisini degil, nesneye giden handle'i tutar.
- Handle varsayilan olarak `null` durumundadir; gercek nesne `new()` ile olusturulur.
- Constructor icinde verilen `name` bilgisi, nesneyi loglarda ayirt etmek icin kullanilir.
- `this.name` kullanimi, constructor argumani ile class property'sini net sekilde ayirir.
- `rand bit [7:0] data[3:0];` tanimi, sabit boyutlu bir dizinin randomize edilebildigini gosterir.

### Onemli Notlar

- Class adi ayni zamanda type adidir.
- Method'lar class icindeki davranisi tasir; bu ornekte `new()` ve `show()` kullaniliyor.
- `randomize()` cagrisindan sonra `show()` ile handle ve alanlar yazdiriliyor.
- Bu dersin ana amaci UVM'e gecmeden once OOP tabanini oturtmaktir.

### Bu Klasorde Ne Var

- `tb.sv`: temel class tanimi, nesne olusturma ve basit randomization ornegi
- `flist.f`: derleme dosya listesi
- `Makefile`: Verilator ile hizli derleme ve calistirma

## English

This lesson applies the basic class and object concepts from the PDF to the first example in the repository.

- The `stack` class defines a new data type.
- The declaration `stack s;` stores an object handle, not the object itself.
- A handle starts as `null`; the real object is created with `new()`.
- The constructor argument `name` is used to identify the instance in logs.
- `this.name` separates the constructor argument from the class property.
- `rand bit [7:0] data[3:0];` shows that a fixed-size array can be randomized.

### Key Notes

- A class name is also a type name.
- Methods carry behavior inside the class; this example uses `new()` and `show()`.
- After `randomize()`, the code prints the handle and field values with `show()`.
- The goal of this lesson is to establish the OOP foundation before moving toward UVM-style structures.

### Files In This Folder

- `tb.sv`: basic class declaration, object construction, and simple randomization example
- `flist.f`: compile file list
- `Makefile`: quick build and run flow with Verilator
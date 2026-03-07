# Ders 005 - Inheritance ve Constraint Katmanlama

## Turkce

Bu ders, PDF'deki inheritance temasini basit bir class hiyerarsisi uzerinden anlatiyor.

- `door_stack extends stack;` satiri ile tureyen sinif, base class'in veri ve methodlarini devralir.
- `super.new(name);` cagrisi, base class constructor'inin da calismasini saglar.
- `door_stack` icinde `constraint SIZE_C {}` tanimi yapilarak base constraint override ediliyor.
- Bu yapi, ayni veri modelini koruyup farkli randomization davranislari uretebilmek icin kullanislidir.

### Onemli Notlar

- Tureyen sinif ayri bir data type'tir.
- Inheritance, kod tekrarini azaltirken davranis farklarini kontrollu sekilde eklemeyi saglar.
- Constraint override veya constraint layering, verification siniflarinda cok sik kullanilir.
- Bu ornekte test akisi base class ile calisiyor; derived class ise genisletme mantigini gostermek icin eklenmis durumda.

### Bu Klasorde Ne Var

- `tb.sv`: base class, derived class ve constructor zinciri ornegi
- `flist.f`: derleme dosya listesi
- `Makefile`: Verilator akisi

## English

This lesson explains the inheritance theme from the PDF through a small class hierarchy.

- `door_stack extends stack;` shows that the derived class inherits the data and methods of the base class.
- The call `super.new(name);` ensures that the base-class constructor also runs.
- The definition `constraint SIZE_C {}` inside `door_stack` overrides the base constraint.
- This structure is useful when you want to keep the same data model but produce different randomization behavior.

### Key Notes

- A derived class is a separate data type.
- Inheritance reduces duplication while allowing controlled behavior changes.
- Constraint override or constraint layering is very common in verification classes.
- In this example, the test flow still runs with the base class; the derived class is present to illustrate the extension mechanism.

### Files In This Folder

- `tb.sv`: base class, derived class, and constructor chaining example
- `flist.f`: compile file list
- `Makefile`: Verilator flow
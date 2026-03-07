# Ders 002 - Randomization, Constraint ve Dinamik Dizi

## Turkce

Bu ders, PDF'deki basic classes and randomization akisinin constraint ve dinamik dizi tarafini somutlastiriyor.

- `stack_size` enum'u ile kucuk, orta ve buyuk boyut siniflari tanimlaniyor.
- `length`, `data[]` ve `ssize` alanlari `rand` olarak tanimlandigi icin solver tarafindan seciliyor.
- `SIZE_C` constraint'i, secilen `ssize` degerine gore `length` araligini belirliyor.
- `solve ssize before length;` ve `solve length before data;` kurallari cozum sirasini netlestiriyor.
- `post_randomize()` icinde `data = new[length];` ile dinamik dizi olusturuluyor.

### Onemli Notlar

- Dinamik dizilerde boyut runtime sirasinda belirlenir.
- `post_randomize()` sadece randomization basarili olduktan sonra calisir.
- `randomize() with { ssize == L; }` kullanimi, cagrim aninda ek constraint eklemenin pratik yoludur.
- Solver sirasi yanlis kuruldugunda veya constraint'ler celistiginde randomization basarisiz olabilir.

### Bu Klasorde Ne Var

- `tb.sv`: enum, constraint, dinamik dizi ve `post_randomize()` ornegi
- `flist.f`: derleme dosya listesi
- `Makefile`: `make sim` ile derle ve calistir akisi

## English

This lesson turns the constraint and dynamic-array part of the PDF's basic classes and randomization flow into a concrete example.

- The `stack_size` enum defines small, medium, and large size classes.
- `length`, `data[]`, and `ssize` are declared as `rand`, so the solver chooses their values.
- The `SIZE_C` constraint limits the `length` range based on the selected `ssize`.
- `solve ssize before length;` and `solve length before data;` make the solving order explicit.
- `post_randomize()` creates the dynamic array with `data = new[length];`.

### Key Notes

- Dynamic arrays get their size at runtime.
- `post_randomize()` runs only after a successful randomization.
- `randomize() with { ssize == L; }` is a practical way to add an inline constraint at the call site.
- Randomization can fail if constraints conflict or if the solve order is poorly defined.

### Files In This Folder

- `tb.sv`: enum, constraints, dynamic array, and `post_randomize()` example
- `flist.f`: compile file list
- `Makefile`: build-and-run flow with `make sim`
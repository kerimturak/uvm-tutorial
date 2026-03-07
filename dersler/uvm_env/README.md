# Lesson 1 — SystemVerilog Class Basics

English:

A class groups data and subroutines (functions/tasks) that operate on that data. Data inside a class are called "properties" and subroutines are called "methods".

- Example: a `stack` class might have `sp`, `data` as properties and `new`, `print` as methods.

Class Declaration:
````markdown
# Lesson 2 — Randomization, Constraints and Dynamic Arrays (SV)

Türkçe + English kısa özet:

- Bu ders `randomize()` kullanımı, `constraint` tanımları, `post_randomize()` ve dinamik array'ler üzerinde durur.
- This lesson demonstrates `randomize()`, constraints, `post_randomize()` and dynamic arrays.

**Ne gösteriliyor / What this shows**

- `typedef enum` ile boyut seçimi (`stack_size`).
- Sınıf içinde `rand` anahtar kelimesi ile rastgele seçilebilen alanlar (`length`, `data`, `ssize`).
- `constraint` blokları ile bağlı alanlar için kurallar ve `solve ... before` ile seçim sırası kontrolü.
- `post_randomize()` içinde dinamik array uzunluğunu ayarlama ve içeriği doldurma.

**Önemli kavramlar / Key concepts**

- `rand` değişkenler: Rastgeleleşme sırasında değer alır.
- `constraint`lar: Rastgeleleşme esnasında sağlanması gereken koşullar.
- `solve A before B`: A'nın B'den önce seçilmesini zorlar (ör. önce `ssize`, sonra `length`, sonra `data`).
- `post_randomize()`: `randomize()` tamamlandıktan sonra otomatik çağrılır; hesaplamalar veya dinamik bellek atamaları için kullanılır.
- Dinamik array'ler: Boyutu runtime'ta belirlenir (`data = new[length];`).

**Kodun özeti / Summary of `tb.sv`**

- `stack` sınıfı:
  - `string name` — örnek adı
  - `rand int unsigned length` — dinamik array uzunluğu
  - `rand bit [7:0] data[]` — dinamik byte array
  - `rand stack_size ssize` — enum (S, M, L) ile boyut sınıfı
  - `constraint SIZE_C` — `ssize` değerine göre `length` aralığını kısıtlar
  - `constraint ORDER_C` — seçim sırasını belirler
  - `post_randomize()` — `data = new[length];` ve rastgele içerik ataması

Örnek davranış (modül `tb`):

- `s = new("ilk_stack");`
- `s.randomize() with { ssize == L; }` — inline constraint ile `ssize` L olarak zorlanır
- Başarısız olursa `fatal`, başarılı olursa `s.show()` ile içerik yazdırılır

**Dosyalar**

- Örnek test: [ders_002/tb.sv](ders_002/tb.sv#L1-L200)

**Çalıştırma / Run**

Bu klasörde bir `Makefile` vardır — derleme ve çalıştırma için dizinde `make sim` veya ayrı `make compile` ardından `make run` kullanabilirsiniz.

Örnek:

```bash
cd dersler/ders_002
make sim
```

Not: Bu repo `verilator` ile simülasyon derleme komutları içerir (Makefile içinde görülür).

**Açıklamalar / Notes**

- Eğer `randomize()` başarısız oluyorsa, constraint'leri ve `solve ... before` sırasını kontrol edin.
- `post_randomize()` içinde dinamik array oluşturulup doldurulması, `data` gibi alanların doğru boyutta olmasını sağlar.
- `with { ... }` ile çağrı sırasında ek/inline constraint uygulanabilir.

Kısa örnek açıklama (Türkçe): `ssize==L` zorlanınca `length` 8..12 aralığında seçilecek, sonra `data` için `length` kadar eleman oluşturulup doldurulacaktır.

````
- Varsayılan olarak handle `null`'dür; `new()` çağrılana kadar instance yoktur.

# Lesson 1 — SystemVerilog Class Basics

English:

A class groups data and subroutines (functions/tasks) that operate on that data. Data inside a class are called "properties" and subroutines are called "methods".

- Example: a `stack` class might have `sp`, `data` as properties and `new`, `print` as methods.

Class Declaration:

- Properties: data fields inside the class.
- Methods: functions or tasks operating on those properties.
- The class name is a type used to declare a class variable (a handle).

Object Handle:

- A handle is a variable that holds a reference to an object in memory (its address). It does not contain the object itself.
- By default a handle is `null` until `new()` is called.

Class Instance (Constructor):

- An object (instance) is created by calling the class constructor `new()`.
- `new()` allocates the instance in memory and sets the handle to reference it.
- You can call `new()` at declaration or later in procedural code.

Constructor Rules:

- A default constructor exists for every class if you do not define one.
- You can define an explicit `new` constructor to initialize properties or call other methods.
- An explicit constructor follows function rules but has no return type.

Default Values (when no explicit constructor):

- `logic` properties default to `'bx`.
- `bit` properties default to `'b0`.

Code example (English):

```systemverilog
class stack;
  bit [7:0] data[15];
  bit [3:0] sp;

  function new();
    $display("New object is created");
    foreach (data[i]) begin
      data[i] = i;
      $display("data[%0d] : %0d", i, data[i]);
    end
  endfunction
endclass

module tb ();
  stack s; // handle (null)
  initial begin
    s = new();
  end
endmodule
```

Türkçe:

Bir sınıf, verileri ve bu veriler üzerinde işlem yapan alt programları (fonksiyonlar/görevler) bir arada tutar. Sınıf içindeki verilere "özellikler (properties)", alt programlara ise "metodlar (methods)" denir.

- Örnek: `stack` sınıfı `sp`, `data` özelliklerine; `new`, `print` metodlarına sahip olabilir.

Sınıf Tanımı:

- Özellikler: Sınıf içindeki veri alanları.
- Metodlar: Bu özellikler üzerinde işlem yapan fonksiyonlar veya task'lar.
- Sınıf adı, bir sınıf değişkeni (handle) tanımlamak için tür olarak kullanılır.

Handle (Nesne Tutucu):

- Handle, bellekdeki bir nesneye referans (adres) tutan değişkendir; nesnenin kendisini taşımaz.
- Varsayılan olarak handle `null`'dür; `new()` çağrılana kadar instance yoktur.

Sınıf Örneği (Constructor):

- Bir nesne, sınıfın constructor'ı `new()` çağrılarak oluşturulur.
- `new()` bellekte instance tahsis eder ve handle'a bu adresi atar.
- `new()` hem deklarasyon esnasında hem de prosedürel kod içinde çağrılabilir.

Constructor Kuralları:

- Eğer tanımlamazsanız her sınıf için bir varsayılan constructor vardır.
- `new` adında explicit bir constructor tanımlayarak özellikleri başlatabilir veya diğer metodları çağırabilirsiniz.
- Explicit constructor normal fonksiyon kurallarına uyar fakat dönüş tipi yoktur.

Varsayılan Değerler (Explicit Constructor Yoksa):

- `logic` türündeki özellikler varsayılan `'bx` değerini alır.
- `bit` türündeki özellikler varsayılan `'b0` değerini alır.

Kod örneği (Türkçe açıklama ile aynı kod):

```systemverilog
class stack;
  bit [7:0] data[15]; // property — bit türü, varsayılan 'b0
  bit [3:0] sp;

  function new();
    $display("Yeni nesne oluşturuldu");
    foreach (data[i]) begin
      data[i] = i;
      $display("data[%0d] : %0d", i, data[i]);
    end
  endfunction
endclass

module tb ();
  stack s; // handle (null)
  initial begin
    s = new(); // constructor çağrısı
  end
endmodule
```

### Bilinmesi Gerekenler

- A class groups data and subroutines (functions/tasks)
    - variables = properties
    - task & function = methods
- Object Handle = 
- Class == Data Type
    - An object is an instance of that class.
- An object (instance) is created by calling the class constructor new().
- new() allocates the instance in memory and sets the handle to reference it
```
    STACK
    +------+
    |  p   | -----------+
    +------+            |
                        v
    HEAP            +----------+
                    | Packet   |
                    | data=?   |
                    +----------+
```

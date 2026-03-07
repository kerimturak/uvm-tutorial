Evet. Bu bölüm birkaç farklı ama birbiriyle bağlantılı konuyu anlatıyor. En önemlisi **interface class**, sonra **typedef class (forward declaration)**, sonra da **class vs struct** ve **memory management**.

En kritik kısmı önce söyleyeyim:

```text
interface class = “bu davranışları sağlayacaksın” sözleşmesi
virtual class   = “kısmen tanımlı abstract base class”
class           = gerçek implementasyon
```

Yani interface class, bir class’a **davranış kontratı** zorlar; ama implementasyon vermez.

---

# 1) Interface class nedir?

Standarttaki fikir şu:

Bazen bir grup class’ın ortak bir davranış seti vardır, ama bunların aynı base class’tan türemesi gerekmez.

Örnek düşün:

* `Fifo`
* `Stack`

İkisi de:

* `put(...)` yapabiliyor
* `get()` yapabiliyor

Ama iç implementasyonları farklı:

* FIFO: sondan ekle, baştan al
* Stack: başa ekle, baştan al

Bu ortak davranışı tanımlamak için:

```systemverilog
interface class PutImp#(type PUT_T = logic);
  pure virtual function void put(PUT_T a);
endclass

interface class GetImp#(type GET_T = logic);
  pure virtual function GET_T get();
endclass
```

Burada deniyor ki:

* `PutImp` implement eden herkes `put(...)` sağlayacak
* `GetImp` implement eden herkes `get()` sağlayacak

Ama interface class kendi içinde gerçek kod taşımaz; sadece **pure virtual method prototype** taşır.

---

# 2) Interface class içinde neler olabilir, neler olamaz?

Olabilir:

* `pure virtual method`
* `typedef`
* `parameter / localparam`

Olamaz:

* veri üyeleri
* constraint block
* covergroup
* nested class

Yani interface class neredeyse sadece bir **API tanımı** gibidir.

Şöyle düşünebilirsin:

```text
class            = data + behavior
virtual class    = partial behavior + abstract contract
interface class  = sadece contract
```

---

# 3) implements ne demek?

Bir normal class, bir veya daha fazla interface class’ı şöyle implement eder:

```systemverilog
class Fifo#(type T = logic, int DEPTH = 1)
  implements PutImp#(T), GetImp#(T);

  T myFifo[$:DEPTH-1];

  virtual function void put(T a);
    myFifo.push_back(a);
  endfunction

  virtual function T get();
    get = myFifo.pop_front();
  endfunction

endclass
```

Anlamı:

* `Fifo`, `PutImp` ve `GetImp` kontratlarını kabul ediyor
* o yüzden `put` ve `get` methodlarını sağlamak zorunda

Aynı şekilde:

```systemverilog
class Stack#(type T = logic, int DEPTH = 1)
  implements PutImp#(T), GetImp#(T);

  T myFifo[$:DEPTH-1];

  virtual function void put(T a);
    myFifo.push_front(a);
  endfunction

  virtual function T get();
    get = myFifo.pop_front();
  endfunction

endclass
```

Burada da aynı davranış kontratı var ama implementasyon farklı.

Bu çok önemli:

```text
Ortak davranış var, ortak implementasyon olmak zorunda değil.
```

---

# 4) extends ile implements farkı

Bu bölümün en kritik noktalarından biri bu.

## `extends`

Bir class’tan miras alırsın.

* üyeler inherit edilir
* methodlar inherit edilir
* data inherit edilir

## `implements`

Bir interface class’ın methodlarını sağlama zorunluluğu doğar.

* hiçbir şey inherit edilmez
* sadece “şu methodları implement edeceksin” denir

Kısa tablo:

| keyword      | anlam                 |
| ------------ | --------------------- |
| `extends`    | miras al              |
| `implements` | kontratı yerine getir |

Örnek:

```systemverilog
class MyQueue #(type T = logic, int DEPTH = 1);
  T PipeQueue[$:DEPTH-1];

  virtual function void deleteQ();
    PipeQueue.delete();
  endfunction
endclass
```

ve

```systemverilog
class Fifo #(type T = logic, int DEPTH = 1)
  extends MyQueue#(T, DEPTH)
  implements PutImp#(T), GetImp#(T);

  virtual function void put(T a);
    PipeQueue.push_back(a);
  endfunction

  virtual function T get();
    get = PipeQueue.pop_front();
  endfunction
endclass
```

Burada:

* `PipeQueue` ve `deleteQ()` → `extends` ile geliyor
* `put()` ve `get()` → `implements` yüzünden yazılmak zorunda

---

# 5) Interface class extend edebilir mi?

Evet, ama sadece başka interface class’ları extend edebilir.

```text
interface class
  -> extend interface class
  -> implement edemez
```

Normal class ise:

```text
class / virtual class
  -> interface class extend edemez
  -> interface class implement edebilir
```

Bu ayrım çok önemli.

---

# 6) Interface method implementasyonu inherited olabilir mi?

Evet, ama inherited method **virtual** olmalı.

Örnek:

```systemverilog
interface class IntfClass;
  pure virtual function bit funcBase();
  pure virtual function bit funcExt();
endclass

class BaseClass;
  virtual function bit funcBase();
    return 1;
  endfunction
endclass

class ExtClass extends BaseClass implements IntfClass;
  virtual function bit funcExt();
    return 0;
  endfunction
endclass
```

Burada `ExtClass`, `IntfClass`’ı implement ediyor. Gerekli methodlar:

* `funcBase`
* `funcExt`

`funcExt`’i kendisi yazıyor.
`funcBase`’i ise `BaseClass`’tan **virtual** olarak inherit ediyor. Bu geçerli.

Ama inherited method **non-virtual** ise yetmez.

Örnek:

```systemverilog
class BaseClass;
  function void f();
    $display("Called BaseClass::f()");
  endfunction
endclass
```

Bu `f()` non-virtual olduğu için interface requirement’ı karşılamaz. O yüzden derived class’ta tekrar `virtual function void f()` yazman gerekir.

---

# 7) Interface class handle ne işe yarar?

Şu çok güçlü bir özellik:

```systemverilog
PutImp#(int) put_ref;
Fifo#(int) fifo_obj = new;
put_ref = fifo_obj;
```

Burada `put_ref` bir **interface class type handle**.

Anlamı:

* `fifo_obj` gerçek nesne
* ama ben ona `PutImp#(int)` perspektifinden bakıyorum

Bu polymorphism sağlar.

Yani sen sadece şunu umursarsın:

```text
Bu obje put(...) yapabiliyor mu?
```

Objenin FIFO mu, Stack mi olduğu ikinci planda kalır.

---

# 8) “Sadece methodlar aynıysa yeter mi?”

Hayır. Bu çok önemli bir kural.

Bir class’ın tüm method imzaları aynı olsa bile, eğer açıkça

```systemverilog
implements SomeInterface
```

demediyse, o class **o interface’i implement ediyor sayılmaz**.

Yani “duck typing” yok. Bildirmen gerekiyor.

---

# 9) Casting

Örnek:

```systemverilog
Fifo#(int) fifo_obj = new;
PutImp#(int) put_ref = fifo_obj;
GetImp#(int) get_ref;

$cast(get_ref, put_ref);
```

Bu neden legal?

Çünkü `put_ref` aslında runtime’da `Fifo#(int)` nesnesini gösteriyor ve `Fifo#(int)` hem `PutImp#(int)` hem `GetImp#(int)` implement ediyor.

Yani:

```text
actual object type önemli
```

Ayrıca:

```systemverilog
$cast(fifo_obj, put_ref); // legal
$cast(put_ref, fifo_obj); // legal ama cast şart değil
```

Ama interface class instance’ı doğrudan oluşturulamaz:

```systemverilog
put_ref = new(); // illegal
```

Çünkü interface class soyut bir tiptir.

---

# 10) Type access: typedef ve parameter mirası

Burada ince bir nokta var.

## Interface class `extends` ederse

typedef ve parameter’lar inherit edilir.

Örnek:

```systemverilog
interface class IntfA #(type T1 = logic);
  typedef T1[1:0] T2;
  pure virtual function T2 funcA();
endclass

interface class IntfB #(type T = bit) extends IntfA #(T);
  pure virtual function T2 funcB(); // legal
endclass
```

Burada `IntfB`, `T2`’yi görebiliyor çünkü `extends` ile geldi.

## Class `implements` ederse

typedef ve parameter’lar inherit edilmez.

Örnek:

```systemverilog
interface class IntfC;
  typedef enum {ONE, TWO, THREE} t1_t;
  pure virtual function t1_t funcC();
endclass

class ClassA implements IntfC;
  t1_t t1_i; // illegal
  virtual function IntfC::t1_t funcC();
    return IntfC::ONE;
  endfunction
endclass
```

Burada `t1_t` doğrudan görünmez. Çünkü `implements` miras vermez. Bu yüzden `IntfC::t1_t` yazmak gerekir.

---

# 11) implements ile type parameter kullanma kısıtı

Şunlar illegal:

```systemverilog
class Fifo #(type T = PutImp) implements T;
virtual class Fifo #(type T = PutImp) implements T;
interface class Fifo #(type T = PutImp) extends T;
```

Yani `implements` veya `extends` tarafında “belki interface class’a çözülecek bir type parameter” kullanamazsın. Derleyici burada açık ve sabit bir interface class tipi ister.

---

# 12) Name conflict

Bir class birden fazla interface class implement edince aynı isimli methodlar/typedef’ler çakışabilir.

## Method conflict çözülebiliyorsa

Tek bir implementasyon hepsini karşılayabilir.

```systemverilog
interface class IntfBase1;
  pure virtual function bit funcBase();
endclass

interface class IntfBase2;
  pure virtual function bit funcBase();
endclass

virtual class ClassBase;
  pure virtual function bit funcBase();
endclass

class ClassExt extends ClassBase implements IntfBase1, IntfBase2;
  virtual function bit funcBase();
    return 0;
  endfunction
endclass
```

Bu tek `funcBase()` hepsini aynı anda karşılıyor.

## Çözülemiyorsa

Hata olur.

```systemverilog
interface class IntfBaseA;
  pure virtual function bit funcBase();
endclass

interface class IntfBaseB;
  pure virtual function string funcBase();
endclass
```

Burada aynı isim ama dönüş tipleri farklı. Tek method ile ikisini aynı anda karşılayamazsın. Bu yüzden illegal.

---

# 13) Diamond relationship

Bu klasik çoklu miras problemi.

Örnek:

```systemverilog
interface class IntfBase;
  parameter SIZE = 64;
endclass

interface class IntfExt1 extends IntfBase;
endclass

interface class IntfExt2 extends IntfBase;
endclass

interface class IntfExt3 extends IntfExt1, IntfExt2;
endclass
```

Burada `IntfExt3`, `IntfBase`’e iki yoldan ulaşıyor:

* `IntfExt1` üzerinden
* `IntfExt2` üzerinden

Ama kök aynı interface class olduğu için `SIZE` sadece **bir kez** merge edilir. Çakışma sayılmaz.

Fakat farklı specialization’lar varsa artık aynı tip sayılmaz:

```systemverilog
interface class IntfBase #(type T = int);
  pure virtual function bit funcBase();
endclass

interface class IntfExt1 extends IntfBase#(bit);
endclass

interface class IntfExt2 extends IntfBase#(logic);
endclass
```

Burada `IntfBase#(bit)` ve `IntfBase#(logic)` farklı specialization olduğu için diamond “tek kopya” davranışı uygulanmaz; conflict oluşabilir ve çözmen gerekir.

---

# 14) Partial implementation

Bu çok önemli ve virtual class ile interface class bağlantısını gösteriyor.

```systemverilog
interface class IntfClass;
  pure virtual function bit funcA();
  pure virtual function bit funcB();
endclass
```

Kısmi implementasyon:

```systemverilog
virtual class ClassA implements IntfClass;
  virtual function bit funcA();
    return 1;
  endfunction

  pure virtual function bit funcB();
endclass
```

Burada `ClassA`:

* `funcA()`’yı implement ediyor
* `funcB()`’yi halen pure bırakıyor

Bu legal çünkü `ClassA` zaten `virtual class`.

Sonra tam implementasyon:

```systemverilog
class ClassB extends ClassA;
  virtual function bit funcB();
    return 1;
  endfunction
endclass
```

Yani:

```text
interface class + virtual class = kademeli implementasyon
```

Ama önemli kural şu:
Bir virtual class interface class implement ediyorsa, her method için ya

* implementasyon vermeli
* ya da tekrar `pure virtual` olarak declare etmeli

Hiçbir şey yapmadan bırakamaz.

---

# 15) Method default argument values

Interface class içindeki method prototype’larında default argüman olabilir.

Ama bu default değer:

* constant expression olmalı
* her implementasyonda aynı anlamı taşımalı

Yani sözleşmenin bir parçası gibi düşün.

---

# 16) Constraint, covergroup, randomization

Interface class içinde:

* constraint block yok
* covergroup yok
* data member yok

Ama interface class handle üzerinde `randomize()` çağrısı legal olabilir.

Pratikte çok sınırlı faydası var çünkü interface class veri taşımaz. Dolayısıyla constraint yazacak state yok denecek kadar azdır.

Bir istisna daha var:
`pre_randomize()` ve `post_randomize()` built-in empty virtual methods olarak vardır ve override edilebilir.

---

# 17) Typedef class nedir? Forward declaration

Bu da çok önemli.

Bazen iki class birbirini referans eder:

```systemverilog
class C1;
  C2 c;
endclass

class C2;
  C1 c;
endclass
```

Bu doğrudan yazılırsa derleyici `C1`’i parse ederken `C2`’yi henüz bilmiyor olabilir.

Bunu çözmek için forward declaration:

```systemverilog
typedef class C2;

class C1;
  C2 c;
endclass

class C2;
  C1 c;
endclass
```

Bu şu anlama gelir:

```text
C2 diye bir class tipi olacak, birazdan tanımlanacak.
```

Not: standart diyor ki

```systemverilog
typedef class C2;
```

ile

```systemverilog
typedef C2;
```

aynı işi görür; `class` keyword’ü daha çok dokümantasyon amaçlıdır.

---

# 18) Parameterized class için forward typedef

Bu da mümkün:

```systemverilog
typedef class C;

module top;
  C#(1, real) v2;
  C#(.p(2), .T(real)) v3;
endmodule

class C #(parameter p = 2, type T = int);
endclass
```

Yani parametreli class henüz aşağıda tanımlı olsa bile önden “var olacak” diye haber verebilirsin.

---

# 19) Class ve struct farkı

Standart burada üç temel fark söylüyor.

## a) Struct statiktir, class dinamiktir

`struct`:

* static/global memory’de olabilir
* task stack’inde olabilir

`class`:

* declaration nesneyi yaratmaz
* nesne `new` ile dinamik oluşur

Örnek:

```systemverilog
typedef struct {
  int a;
} s_t;

class C;
  int a;
endclass

s_t s;      // veri oluştu
C c;        // sadece handle
c = new();  // gerçek obje şimdi oluştu
```

## b) Class handle kullanır

Class değişkeni aslında object’in kendisi değil, handle’dır.

```text
C c;
```

burada `c` bir handle.

## c) Class polymorphism sağlar

Struct:

* encapsulation benzeri kullanım verir
* ama inheritance/polymorphism yok

Class:

* inheritance
* abstract class
* dynamic cast
* polymorphism

Bu yüzden UVM gibi OOP tabanlı verification dünyasında class zorunlu hale gelir.

---

# 20) Memory management

SystemVerilog:

* object
* string
* dynamic array
* associative array

için belleği dinamik ayırır ve otomatik toplar.

Yani dilde garbage collection benzeri otomatik yönetim var.

Örnek:

```systemverilog
myClass obj = new;

fork
  task1(obj);
  task2(obj);
join_none
```

Burada hangi process’in objeyi ne zaman bırakacağını tek bir thread bilemez. C gibi `free()` tabanlı manuel model çok riskli olurdu.

Bu yüzden SystemVerilog der ki:

* kullanıcı `free` yapmaz
* referans kalmayınca sistem toplar

Kullanıcı açısından pratik anlamı:

```systemverilog
obj = null;
```

gibi handle’ları bırakman yeterlidir.

Standart ayrıca şunu söyler:
Bir object,

* aktif scope’larda hâlâ referans varsa
* ya da pending NBA ile non-static member’a erişim varsa

geri toplanmaz.

---

# 21) UVM açısından neden önemli?

Bu konular UVM’de şöyle karşına çıkar:

* **interface class**: TLM port/export/imp mantığını anlamakta çok yardımcı olur
* **typedef class**: karşılıklı referans veren class’larda kullanılır
* **class vs struct**: neden transaction’lar class diye yazılıyor, onu açıklar
* **memory management**: `new` ile oluşturulan transaction’ların neden manuel free edilmediğini açıklar

Özellikle interface class fikri UVM TLM’de çok önemli bir zihinsel modeldir:
“bir component bu API’yi destekliyor mu?”

---

# 22) Çok kısa özet

* **interface class**: sadece davranış sözleşmesi tanımlar
* **implements**: o sözleşmeyi yerine getirme zorunluluğu getirir
* **extends**: gerçek mirastır, üyeleri taşır
* **implements hiçbir şeyi inherit etmez**
* **virtual class** interface class’ı kısmen implement edebilir
* **typedef class**: ileri bildirimdir
* **class** dinamik ve polymorphic’tir, `struct` değildir
* **memory** otomatik yönetilir

İstersen bir sonraki adımda bunları UVM bağlamına çevirip özellikle şu üçlü arasındaki farkı net bir tabloyla çıkarayım:

`virtual interface` vs `virtual class` vs `interface class`

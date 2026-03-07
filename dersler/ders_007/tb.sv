class door;
  string name;

  rand logic [2:0] addr;

  function new(string name);
    this.name = name;
  endfunction

  virtual function void whoami();
    $display("I am door: %s, addr: %0d", name, addr);
  endfunction
endclass

class stack;
  string name;
  // Bir class’ın property’si başka bir class’ın instance’ı olabilir
  // aggregate members (handles)
  //Randomization aggregate class içinde hiyerarşik olarak aşağı doğru iner, ama sadece property rand olarak tanımlıysa.
  // Randomization yalnızca rand property üzerinden ilerler
  rand door d1;
  rand door d2;
  // sadece handle (referance)
  function new(string name);
    this.name = name;

    // IMPORTANT: create the sub-objects
    d1 = new({name, ".d1"});
    d2 = new({name, ".d2"});
  endfunction

  function void whoami();
    $display("I am stack: %s", name);
      // handle chain
      d1.whoami();
      d2.whoami();
  endfunction
endclass

module tb;
  stack s1;
  stack s2;

  initial begin
    //s1 = new("S");
    //s2 null

    //s2 = s1; // s1 ve s2 aynı objecyi gösterir

/*
s1 ──┐
     ├──→ s object
s2 ──┘

reference copy, handle copy diyoruz
*/

    // handle chain access (class hierarchy like module hierarchy)
    /*
    s1.randomize();
    s2 = null;  // objec i silmez sadece referansı kaldırır
    s2.whoami();
    s1 = null;
*/
    // Reference copy verification’da bug oluşturabilir.



    // Reference copy aynı object’i paylaşır; clone ise yeni bir object oluşturur.
/*
    s1 = new("S1");
    s1.randomize();

    s2 = new("S2");

    s2.d1 = s1.d1;
    s2.d2 = s1.d2;
*/
    // local ve protected fieldlar kopyalanamaz


/*
tüm propertyler kopyalanır
local
protected
instance name
*/

  // shadow clone sadece ilk seviyedeki object kopyalanır
    s1 = new("S1");
    s1.randomize();


  // Deep clone tüm object hiyerarşisini kopyalar
    s2 = new s1;
    s2.d1 = new s1.d1;
    s2.d2 = new s1.d2;
    s2.whoami();
  end
endmodule
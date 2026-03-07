class stack;
  string name;

  function new(string name);
    this.name = name;
  endfunction

  virtual function void whoami();
    $display("I am stack");
  endfunction
endclass

// Yani bir subclass tanımlandığınızda yeni bir ver idütür tanımlamış oluyorsunuz
class door_stack extends stack;

  function new(string name);
    super.new(name);
  endfunction

  function void whoami();
    $display("I am door stack");
  endfunction
endclass

// Bir base class handle o handledan türetilmiş herhangi bir subclass nesnesi tutabilir

module tb;
  stack s;        // base handle
  door_stack d;   // derived handle
  door_stack d_2;   // derived handle

  initial begin
    d = new("door1"); // instance

    // subclass handle canbe assigned directly to a parent class
    // derived object -> base hanle type atamak her zaman geçerlidir.
    s = d;

    // base class üzerinde sadece base class içerisindeki üyeler görülür
    s.whoami();


    //base hanle ->  derived object  geçersizdir

    // Casting
    $cast(d_2, s);

    d_2.whoami();

    // Casting sayesinde alt sınıf (subclass) örnekleri, üst sınıf (parent class) için tanımlanmış kaynakları kullanabilir.


    // V'rtual methodlari
    // default olarak member access handle type üzerinden çözülür
    // fakat virtual method handle'ın içeriğine göre çözülür
    //  bir kez virtual olarak tanımlarsanız her yerde virtual olur

  end
endmodule
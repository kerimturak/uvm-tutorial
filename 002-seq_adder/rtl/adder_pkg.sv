/*
 Github   : https://github.com/kerimturak
 Linkedin : https://www.linkedin.com/in/kerimturak0/
*/

// ----------------------------------------------------------------------
// adder_pkg: UVM Paket Tanımı
// Açıklama:
// - Bu paket, adder (toplayıcı) tasarımının UVM doğrulama ortamında kullanılacak
//   tüm bileşenleri içerir.
// - UVM bileşenleri (sequencer, driver, monitor vb.) bu paketin içine dahildir.
// - `uvm_config_db` kullanılarak **adder_if** sanal arayüzü için yapılandırma tipi tanımlanır.
// ----------------------------------------------------------------------

package adder_pkg;

  // ----------------------------------------------------------------------
  // UVM Paketi Dahil Edilir
  // - `uvm_pkg` tüm UVM bileşenlerini içerir.
  // - `uvm_macros.svh` dosyası, UVM makrolarını (`uvm_info`, `uvm_error`, `uvm_component_utils` vb.)
  //   kullanabilmek için eklenmelidir.
  // ----------------------------------------------------------------------
  import uvm_pkg::*;          // UVM kütüphanesini içe aktar
  `include "uvm_macros.svh"   // UVM makrolarını ekle

  // ----------------------------------------------------------------------
  // Virtual Interface Yapılandırma Tanımı
  // - `adder_if_config`, **adder_if** sanal arayüzünü UVM test ortamına bağlamak için kullanılır.
  // - `uvm_config_db` kullanılarak sanal arayüzün driver ve monitor tarafından erişilmesi sağlanır.
  // ----------------------------------------------------------------------
  typedef uvm_config_db#(virtual adder_if) adder_if_config;

  // ----------------------------------------------------------------------
  // UVM Bileşen Dosyalarının Dahil Edilmesi
  // - Bu dosyalar, adder tasarımını test etmek için gerekli olan tüm UVM bileşenlerini içerir.
  // - **Sırasıyla eklenmelidir**, çünkü bazı dosyalar diğerlerine bağımlıdır.
  // ----------------------------------------------------------------------

  `include "adder_packet.sv"
  `include "adder_sequence.sv"
  `include "adder_sequencer.sv"
  `include "adder_driver.sv"
  `include "adder_monitor.sv"
  `include "adder_agent.sv"
  `include "adder_scoreboard.sv"
  `include "adder_env.sv"
  `include "adder_test.sv"

endpackage : adder_pkg

// ----------------------------------------------------------------------
// KODUN SAĞLADIĞI ÖZELLİKLER
// ----------------------------------------------------------------------
// 1. **UVM Standartlarının Kullanımı**
//    - `uvm_pkg` içe aktarılmıştır, böylece tüm UVM sınıfları kullanılabilir.
//    - `uvm_macros.svh` eklenmiştir, böylece UVM makroları (örn. `uvm_info`) kullanılabilir.
//
// 2. **Sanallaştırılmış Arayüz Yapılandırması**
//    - `adder_if_config`, sanal arayüzü **uvm_config_db** kullanarak bağlamak için tanımlanmıştır.
//
// 3. **UVM Bileşenlerinin Entegre Edilmesi**
//    - **adder_packet.sv**  → Veri işlemleri için UVM nesnesi tanımlanır.
//    - **adder_seqs.sv**     → Veri işlemleri için UVM sequence tanımlanır.
//    - **adder_sequencer.sv** → UVM sequencer (işlem yöneticisi) tanımlanır.
//    - **adder_driver.sv**   → UVM driver (sürücü) tanımlanır ve veriyi DUT'a gönderir.
//    - **adder_monitor.sv**  → UVM monitor (gözlemci) tanımlanır ve veriyi test ortamına iletir.
//
// ----------------------------------------------------------------------
// Bu kod, UVM doğrulama ortamında **paket yönetimi** için optimize edilmiştir.
// ----------------------------------------------------------------------
		
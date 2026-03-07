# Ders 003 - DUT'i Anlamak ve Testbench Iskeleti Kurmak

## Turkce

Bu ders, PDF'deki DUT overview temasina yaklasiyor: once tasarimi anlamak, sonra testbench baglantisini planlamak gerekiyor.

- `spmp_stack.sv` dosyasi tek push girisi ve uc pop portu olan bir stack DUT tanimliyor.
- Pop tarafinda sabit bir oncelik var: `pop_req0 > pop_req1 > pop_req2`.
- `full` sinyali stack doluluk bilgisini verir; `push_ack` ise push kabulunu gosterir.
- Ayni cycle'da hem push hem pop geldiginde veri yolu davranisini dogru yorumlamak gerekir.
- `tb_top.sv` su anda package import eden bir ust iskelet niteliginde; esas fikir derse ait siniflari ayri dosyalara bolmek ve top'ta birlestirmektir.

### Onemli Notlar

- Verification tarafina gecmeden once DUT portlari, reset davranisi ve oncelik kurallari net okunmalidir.
- Testbench tarafinda package kullanmak, buyuyen projede sinif bagimliliklarini daha yonetilebilir hale getirir.
- Bu dersin odagi tam bir UVC degil, DUT'yi ve ust seviye baglanti fikrini kavramaktir.

### Bu Klasorde Ne Var

- `spmp_stack.sv`: ornek stack DUT
- `tb_top.sv`: package tabanli testbench top iskeleti

## English

This lesson is close to the DUT overview theme from the PDF: first understand the design, then plan the testbench connection.

- `spmp_stack.sv` defines a stack DUT with one push input and three pop ports.
- The pop side has a fixed priority: `pop_req0 > pop_req1 > pop_req2`.
- The `full` signal reports stack fullness, and `push_ack` shows push acceptance.
- When push and pop happen in the same cycle, the data-path behavior must be interpreted carefully.
- `tb_top.sv` is currently a package-based top-level skeleton; the main idea is to split class code into separate files and connect them in the top module.

### Key Notes

- Before moving into verification, the DUT ports, reset behavior, and priority rules should be understood clearly.
- Using packages on the testbench side makes class dependencies easier to manage as the project grows.
- The focus of this lesson is not a complete UVC yet; it is understanding the DUT and the top-level integration idea.

### Files In This Folder

- `spmp_stack.sv`: example stack DUT
- `tb_top.sv`: package-based testbench top skeleton
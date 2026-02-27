# UVM + Verilator Eğitim Ortamı

## Hızlı Başlangıç (3 adım)

```bash
# 1. Ortamı kur (her terminal açılışında)
source env.sh

# 2. Bir proje klasörüne gir
cd antmicro-example    # veya: cd cache

# 3. Derle ve çalıştır
make sim
```

## Projeler

| Klasör | Açıklama |
|--------|----------|
| `sv_oop/` | SystemVerilog OOP temelleri (UVM'siz) |
| `antmicro-example/` | Basit UVM testbench örneği |
| `cache/` | Cache donanımı için UVM testbench |
| `new_project_template/` | Yeni proje açmak için şablon |

## Yeni Proje Oluşturma

```bash
cp -r new_project_template/ benim_projem/
cd benim_projem/
# flist.txt ve kaynak dosyaları düzenle
make sim
```

## Komutlar (her proje klasöründe)

```
make compile   — sadece derle
make run       — sadece çalıştır
make sim       — derle + çalıştır
make clean     — temizle
```

## İlk Kurulum (temiz makine)

```bash
chmod +x install.sh
./install.sh
```

## Dosya Yapısı

```
env.sh                    ← ortam değişkenleri (source et)
install.sh                ← ilk kurulum (sadece 1 kez)
antmicro-example/         ← basit UVM örneği
cache/                    ← cache testbench
sv_oop/                   ← SV OOP temelleri
new_project_template/     ← proje şablonu
1800.2-2017-1.0/          ← UVM kaynak kodu
```

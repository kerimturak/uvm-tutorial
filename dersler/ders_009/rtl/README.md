# RTL Yapisi

## Turkce

Bu klasor, ders 009'da dogrulanan referans stack DUT'i tutar.

- Tasarim tek push girisi ve uc pop cikisi olan bir stack yapisidir.
- Pop isteklerinde sabit oncelik vardir: `pop_req0`, sonra `pop_req1`, sonra `pop_req2`.
- `full` sinyali kapasite doldugunda aktif olur.
- `push_ack`, push isleminin kabul edildigini bildirir.
- Stack bos degilse ve herhangi bir pop istegi varsa pop islemi kabul edilir.
- Ayni cycle'da push ve pop birlikte geldiginde pointer sabit kalirken veri akisi buna gore yonetilir.

### Onemli Notlar

- Verification ortami once bu protokol beklentisini dogru modellemelidir.
- Interface tarafindaki sinyal isimleri, bu RTL portlariyla bire bir eslesir.
- Pop veri cikislari ayni veri kaynagini paylasir; hangi portun gecerli oldugu `pop_valid` sinyalleri ile ayirt edilir.

## English

This folder contains the reference stack DUT verified in lesson 009.

- The design is a stack with one push input and three pop outputs.
- Pop requests use a fixed priority: `pop_req0`, then `pop_req1`, then `pop_req2`.
- The `full` signal becomes active when capacity is reached.
- `push_ack` reports that a push operation has been accepted.
- A pop is accepted when the stack is not empty and at least one pop request is active.
- When push and pop happen in the same cycle, the pointer remains stable while the data flow is handled accordingly.

### Key Notes

- The verification environment should model this protocol behavior correctly first.
- The signal names in the interface match these RTL ports directly.
- The pop data outputs share the same data source; the `pop_valid` signals identify which port is valid.
# Registrator2Etcd Service Unit File
[Registrator](https://github.com/gliderlabs/registrator)2Consul docker servisinin soketini dinleyip her türlü değişikliği etcd servisine bildirir. Böylece yeni açılan, kapatılan servisleri takip eder.

Registrator2Etcd global bir servistir ve tüm düğümlerde çalışır.

Registrator servisi için çoklu arka uç (backend) desteği hazır olana kadar geçici bir çözüm olarak çalışmaktadır.

## Bağımlılıkları
Registrator2Etcd Servisi, consul servisinden servisten sonra çalıştırılmalıdır. Ayrıca CoreOs ortam değişkenlerine erişmeye ihtiyaç duyar.

## Kullanım
Unit-file kayıt edilir ve başlatılır:
```
fleetctl submit registrator2etcd.service
fleetctl start registrator2etcd.service
```


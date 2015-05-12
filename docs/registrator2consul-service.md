# Registrator2Consul Service Unit File
[Registrator](https://github.com/gliderlabs/registrator)2Consul docker servisinin soketini dinleyip her türlü değişikliği Consul'e bildirir. Böylece yeni açılan, kapatılan servisleri takip eder.

Registrator2Consul global bir servistir ve tüm düğümlerde çalışır. 

## Bağımlılıkları
Registrator2Consul Servisi, consul servisinden servisten sonra çalıştırılmalıdır. Ayrıca CoreOs ortam değişkenlerine erişmeye ihtiyaç duyar.

## Kullanım
Unit-file kayıt edilir ve başlatılır:
```
fleetctl submit registrator2consul.service
fleetctl start registrator2consul.service
```


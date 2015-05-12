# Consul Service Unit File
Zaerp için kullandığımız consul servisi şuradaki örneği temel almaktadır: https://github.com/democracyworks/consul-coreos

Consul servisi, veri kayıplarının yaşanmaması için en az 3 düğüm küme şeklinde çalışması tavsiye edilir.

Consul, Zaerp için tüm düğümlere kurulur. Düğümler üzerinde çalışan hizmetlerin durumlarının izlenmesinin yanısıra,  DNS hizmetini de üzerine alarak küme içi isim çözümleme yapar.

## Bağımlılıkları
Consul Servisi, docker ve etcd servislerine bağımlıdır. Bu iki servisten sonra çalıştırılmalıdır. Ayrıca CoreOs ortam değişkenlerine erişmeye ihtiyaç duyar.

## Consul
Consul düğümler ve [Registrator](https://github.com/gliderlabs/registrator) veya başka bir araç ile docker konteynerlarının durumlarını izleyebilir.  

## DNS 
Consul çalıştıktan sonra, DNS servisi için systemd-resolved servisine, Consul çalışan konteynerin bilgilerini içeren bir ayar dosyası eklenir ve systemd-resolved hizmeti yeniden başlatılır.

## Kullanım

Unit-file kayıt edilir:

```
fleetctl submit consul@.service
```

İhtiyaç duyulan kadar servis başlatılır:
```
fleetctl start consul@1
fleetctl start consul@2
fleetctl start consul@3
fleetctl start consul@4
fleetctl start consul@5
...
```

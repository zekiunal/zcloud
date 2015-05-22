# zcloud
Bulut araçları ve ayar dosyaları


# Cluster Planı

Cluster'da çok sayıda makine farklı roller ile biraraya getirililir. Ortak servislerin yanısıra her bir makineye özel servis ve ayarlar mevcuttur. 

## Ortak Servisler
Temel ortak servisler, cluster çapında nodelar ayakta mı değil mi, ilgili node üzerinde çalışan servisler vermeleri gereken yanıtları veriyor mu vermiyor mu gibi izleme işlevlerini yerine getiren servislerdir. Bu servisler ya cloud init ile makine açılırken başlatılır ya da servis olarak Global=True flagi ile çalıştırılır. Bu amaçla başlayacak servisler:

* consul
* registrator2etcd
* registrator2consul

## Rol temelli node ve servisler
### Load Balancers
* fleet metatags
	* project=zaerp,machineof=lb,vrrp=$public_ipv4,disk=ssd
* service units
	* haproxy + confd
* keepalived

### Riak
* fleet metatags
	* project=zaerp,machineof=riak,disk=ssd
* service units
	* riak

### RiakCS
* fleet metatags
	* project=zaerp,machineof=riakcs,disk=ssd
* service units
	* riakcs

### Redis
* fleet metatags
	* project=zaerp,machineof=redis,redis=sentinal,disk=ssd
* service units
	* redis

### Zato
* fleet metatags
	* project=zaerp,machineof=zato,zatowebadmin=no,disk=ssd
* service units
	* zatoserver.service

### ZatoWeb
* fleet metatags
	* project=zaerp,machineof=zato,zatowebadmin=yes,disk=ssd
* service units
	* zatowebadmin.service
	* zatoserver.service

### Application
* fleet metatags
	* project=zaerp,machineof=apps,disk=ssd
* service unit files
	* zaerp@.service

### Buildbot
* fleet metatags
	* project=zaerp,machineof=buildbot,disk=nossd
* service unit files
	* buildbot_master.service
	* buildbot_slave.service


## Systemd Unit Files
* consul@.service
* registrator2consul.service
* registrator2etcd.service

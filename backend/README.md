# VirtKick Backend

[![Dependencies status](http://img.shields.io/gemnasium/virtkick/virtkick-backend.svg?style=flat-square)](https://gemnasium.com/virtkick/virtkick-webapp)
[![Gratipay](https://img.shields.io/gratipay/virtkick.svg?style=flat-square)](https://gratipay.com/virtkick/)

This is a temporary, MVP backend for VirtKick.
VirtKick webapp is using it as a JSON API to libvirt.

The backend has been built on top of [WebVirtMgr](https://github.com/retspen/webvirtmgr),
a simple backend for KVM through libvirt. It will soon be replaced with our own backend based on [Fog.io](http://fog.io/).

## Requirements

- Python 2.7
- Linux
- Packages:
  - libvirt 1.2.x with Python bindings
  - QEMU 2.x

## One time setup

```
sudo pip install -r requirements.txt
./manage.py syncdb
./manage.py collectstatic
```

## Development

```
./manage.py runserver
./console/webvirtmgr-novnc
xdg-open http://0.0.0.0:8000/ # open a browser
```

## Hypervisor setup

These steps will be automatically performed by virtkick-webapp. You have to do it yourself if you intend to play with virtkick-backend without virtkick-webapp.

1. Add a new connection.
2. Create a storage pool named `virtkick-iso` where ISOs will be located.
3. Create a storage pool named `virtkick-hdd` where all disks will be located.
4. Create a NAT network `192.168.123.0/24` named `virtkick-nat` with IP pool for DHCP: `192.168.123.2-254`.

## Deployment

```
./manage.py run_gunicorn -c conf/gunicorn.conf.py
```

Since the authentication module is disabled, make sure the server listens on 127.0.0.1.

# License

WebVirtMgr Copyright (C) 2012-2014 Anatoliy Guskov and other contributors

VirtKick WebVirtMgr Backend Copyright (C) 2014 StratusHost Damian Nowak

The code is licensed under the [Apache Licence, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

> [!IMPORTANT]  
> REPOSITORY ARCHIVED: There's a much better alternative available: [temper-python](https://github.com/padelt/temper-python)

# pcsensor-temper
Simple C-program to query temperature from TEMPer-USB-devices. There's a
Munin plugin included too. This repository is prepared for Debian
package builds.

## Supported and tested devices
* `ID 0c45:7401 Microdia` ([M-ware ID7747](http://amzn.to/2fUFUXM))

## Build from source
```bash
sudo apt install git build-essential libusb-dev
git clone "https://github.com/froonix/pcsensor-temper.git"
cd "pcsensor-temper" && make all

# copy udev rule (udev directory)
# copy program (pcsensor file)
# ...
```
## Binary packages (experimental)
Please take a look at the [wiki](https://github.com/froonix/pcsensor-temper/wiki/Binary-Debian-Packages).

## See also
* [Source of this fork](https://github.com/padelt/pcsensor-temper)
* [Original v1.0.0](http://www.isp-sl.com/pcsensor-1.0.0.tgz)

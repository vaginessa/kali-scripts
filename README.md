# Kali on Android Installer
============

## Installation Instructions:

```
mkdir ~/arm-stuff
cd ~/arm-stuff
git clone https://github.com/offensive-security/gcc-arm-linux-gnueabihf-4.7
export PATH=${PATH}:/root/arm-stuff/gcc-arm-linux-gnueabihf-4.7/bin
git clone https://github.com/binkybear/kali-scripts
cd ~/arm-stuff/kali-scripts
./build-deps.sh
./androidmenu.sh
```

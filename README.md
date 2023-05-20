# OpenWrt on Netgear R6220

## Purpose

<!-- <img src="https://i.imgur.com/h400qeU.jpg" width="400px"> -->

This repository contains a modified/customized configuration files from the `/overlay` partition of **OpenWrt** running on **Netgear R6220** router in homelab setup. These files capture the customized settings, specific to homelab environment. 

The purpose of this repository is to keep a backup of the **OpenWrt's** configuration files, enabling easy restoration in case of system issues or system reset.

## Usage

1. To utilize this backup, first of all [Download and Flash latest version of OpenWrt](https://openwrt.org/toh/netgear/r6220#installation) from the official website. 

2. Once **OpenWrt** is flashed and router is up, it will be accessible at `192.168.1.1`, connect router to internet with credentials provided by ISP.

3. Install few packages which are necessary to detect **USB Storage Device** and `mount` it with `ext4` filesystem. Log in to router via **SSH** and run:

```bash
# Update packages list
opkg update

# Install necessary packages
opkg install kmod-usb-storage kmod-fs-ext4 block-mount

# Reboot
reboot
```

 4. Once router comes back, plug the **USB Storage Device** into the router and log in to the LuCI web interface.

 5. Navigate to **System** and click on **Mount Points** in the sub menu.
 
 6. On the **Mount Points** page, click on the **Add** button to create a new mount point.

 7. In the **Mount Points - Mount Entry** section, change the following details:
   
  - UUID: Select connected **USB Storage Device** from the drop-down menu.

  - Mount Point: Select `/overlay` from the drop-down menu.

8. Click the **Save** button to create the mount point. Newly created **Mount Point** should be seen in the list now.

9. Reboot router by navigating to **System** then **Reboot** for changes to take effect.

10. Once the router has rebooted, the USB storage device should be mounted as an overlay at the specified mount point.

11. Now log into router via SSH once again and run:

```bash
# Excute shell script
sh -c "$(curl -s http://gitea.manjeet/manjeet/backup-openwrt.homelab-netgear-r6220/raw/branch/main/configure-homelab.sh)"

# Finally reboot
reboot
```

> Router will be accessible at `10.1.1.1` or `172.16.0.1` after reboot.


### Router Information

```bash
root@OpenWrt:~# cat /proc/cpuinfo

system type                : MediaTek MT7621 ver:1 eco:3
machine                    : Netgear R6220
processor                  : 0
cpu model                  : MIPS 1004Kc V2.15
BogoMIPS                   : 586.13
wait instruction           : yes
microsecond timers         : yes
tlb_entries                : 32
extra interrupt vector     : yes
hardware watchpoint        : yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa                        : mips1 mips2 mips32r1 mips32r2
ASEs implemented           : mips16 dsp mt
Options implemented        : tlb 4kex 4k_cache prefetch mcheck ejtag llsc pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets       : 1
kscratch registers         : 0
package                    : 0
core                       : 0
VPE                        : 0
VCED exceptions            : not available
VCEI exceptions            : not available

processor                  : 1
cpu model                  : MIPS 1004Kc V2.15
BogoMIPS                   : 586.13
wait instruction           : yes
microsecond timers         : yes
tlb_entries                : 32
extra interrupt vector     : yes
hardware watchpoint        : yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa                        : mips1 mips2 mips32r1 mips32r2
ASEs implemented           : mips16 dsp mt
Options implemented        : tlb 4kex 4k_cache prefetch mcheck ejtag llsc pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets       : 1
kscratch registers         : 0
package                    : 0
core                       : 0
VPE                        : 1
VCED exceptions            : not available
VCEI exceptions            : not available


```

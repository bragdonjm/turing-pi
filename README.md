# Turing pi 2 bmc firmware builder
Several instruction sets are showing that the current build tools are missing dependancies. To combat this, I went ahead and started a docker container  
along with this fork so I could feel free to modify a few files here and there without messing around with the original code. I've also added a few  
extra tools, like a dockerized build system complete with a makefile wrapper. I also looke at all pending PRs in the upstream and added those here.  
  
FOR THE EMPIRE!  
  
You will fild the .img in buildroot/output/images/  
  
  
## Legacy build instructions
## Install the necessary dependent packages

```bash
sudo apt-get install build-essential subversion git-core libncurses5-dev zlib1g-dev gawk flex quilt libssl-dev xsltproc libxml-parser-perl mercurial bzr ecj cvs unzip lib32z1 lib32z1-dev lib32stdc++6 libstdc++6 libncurses-dev u-boot-tools mkbootimg bc -y
```

## build

```bash
cd buildroot
make   BR2_EXTERNAL="../br2t113pro"  100ask_t113-pro_spinand_core_defconfig
make cjson-rebuild
make V=1

//update config  //Only once
cd ../
cp bmc4tpi/config/sun8iw20p1* buildroot/output/build/linux-5112fdd843715f1615703ca5ce2a06c1abe5f9ee/arch/arm/boot/dts/
cp bmc4tpi/config/kernelconfig buildroot/output/build/linux-5112fdd843715f1615703ca5ce2a06c1abe5f9ee/.config
cp bmc4tpi/config/swupdateconfig buildroot/output/build/swupdate-2021.11/.config
cp bmc4tpi/swupdate/sw-description buildroot/output/images/
cp bmc4tpi/swupdate/genSWU.sh buildroot/output/images/
cp bmc4tpi/swupdate/env0.fex buildroot/output/images/
cp bmc4tpi/swupdate/env1.fex buildroot/output/images/

//rebuild 
cd buildroot
make linux-rebuild
make swupdate-rebuild

make V=1	//build img

//build swu
cd output/images/
./genSWU.sh 1.0.0	//build swu

//Execute mkfw.sh 1.0.0 in the root directory to directly compile the firmware to the build directory
./mkfw.sh 1.0.0 

```

#!/bin/bash
# Download python and library
sudo apt install -y python3-pip
sudo pip3 install dnslib
sudo pip3 install py_markdown_table

# Copy from setup.sh on installing BCC into env
## Validating kernel config parameters
grep -Ew 'CONFIG_BPF|CONFIG_BPF_SYSCALL|CONFIG_NET_CLS_BPF|CONFIG_NET_ACT_BPF|CONFIG_BPF_JIT|CONFIG_HAVE_EBPF_JIT|CONFIG_BPF_EVENTS|CONFIG_IKHEADERS|CONFIG_NET_SCH_SFQ|CONFIG_NET_ACT_POLICE|CONFIG_NET_ACT_GACT|CONFIG_DUMMY|CONFIG_VXLAN'  /boot/config-5.15.0-1041-azure

echo "Started installing the required packages..."

sudo apt-get update
sudo apt-get install -y bpfcc-tools linux-headers-$(uname -r)
# sudo opensnoop-bpfcc

# echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
wget https://go.dev/dl/go1.20.6.linux-amd64.tar.gz
sudo su
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.6.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
/usr/local/go/bin/go version

export CGO_ENABLED=1
sudo apt install -y zip bison build-essential cmake flex git libedit-dev \
  libllvm12 llvm-12-dev libclang-12-dev python zlib1g-dev libelf-dev libfl-dev python3-setuptools \
  liblzma-dev arping netperf iperf

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4052245BD4284CDD
echo "deb https://repo.iovisor.org/apt/bionic bionic main" | sudo tee /etc/apt/sources.list.d/iovisor.list
sudo apt-get update
sudo apt-get install -y bcc-tools libbcc-examples linux-headers-$(uname -r)

sudo /usr/local/go/bin/go get -u ./...

cd ~
git clone https://github.com/iovisor/bcc.git # Cloned into new directory on the VM
mkdir bcc/build; cd bcc/build
cmake ..
make
sudo make install
cmake -DPYTHON_CMD=python3 .. # build python3 binding
pushd src/python/
make
sudo make install
popd

# mkdir python_ebpf 
# wget -P python_ebpf/ https://gist.githubusercontent.com/oghie/b4e3accf1f87afcb939f884723e2b462/raw/fe60e6b66135640ea39c878589fb092b6eb838a1/final_code_eBPF_dns.py

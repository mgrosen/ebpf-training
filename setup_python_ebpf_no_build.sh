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
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.6.linux-amd64.tar.gz

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

# Download bcc dependencies
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc-0.28.0+18b00a90-py3.8.egg -O /usr/lib/python3/dist-packages/bcc-0.28.0+18b00a90-py3.8.egg
sudo touch /usr/lib/python3/dist-packages/easy-install.pth
sudo echo "./bcc-0.28.0+18b00a90-py3.8.egg" | sudo tee -a /usr/lib/python3/dist-packages/easy-install.pth

sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc.so.0.28.0 -O /usr/lib/x86_64-linux-gnu/libbcc.so.0.28.0
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc.so.0 -O /usr/lib/x86_64-linux-gnu/libbcc.so.0
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc.so -O /usr/lib/x86_64-linux-gnu/libbcc.so
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc.a -O /usr/lib/x86_64-linux-gnu/libbcc.a
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc-loader-static.a -O /usr/lib/x86_64-linux-gnu/libbcc-loader-static.a
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc_bpf.a -O /usr/lib/x86_64-linux-gnu/libbcc_bpf.a
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/file_desc.h -O /usr/include/bcc/file_desc.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/table_desc.h -O /usr/include/bcc/table_desc.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/table_storage.h -O /usr/include/bcc/table_storage.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_common.h -O /usr/include/bcc/bcc_common.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bpf_module.h -O /usr/include/bcc/bpf_module.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_exception.h -O /usr/include/bcc/bcc_exception.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_syms.h -O /usr/include/bcc/bcc_syms.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_proc.h -O /usr/include/bcc/bcc_proc.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_elf.h -O /usr/include/bcc/bcc_elf.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_usdt.h -O /usr/include/bcc/bcc_usdt.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/netdev.h -O /usr/include/bcc/compat/linux/netdev.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/pkt_sched.h -O /usr/include/bcc/compat/linux/pkt_sched.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/perf_event.h -O /usr/include/bcc/compat/linux/perf_event.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/netlink.h -O /usr/include/bcc/compat/linux/netlink.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/fcntl.h -O /usr/include/bcc/compat/linux/fcntl.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/openat2.h -O /usr/include/bcc/compat/linux/openat2.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/btf.h -O /usr/include/bcc/compat/linux/btf.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/if_link.h -O /usr/include/bcc/compat/linux/if_link.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/pkt_cls.h -O /usr/include/bcc/compat/linux/pkt_cls.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bpf_common.h -O /usr/include/bcc/compat/linux/bpf_common.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/if_xdp.h -O /usr/include/bcc/compat/linux/if_xdp.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bpf.h -O /usr/include/bcc/compat/linux/bpf.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc.pc -O /usr/lib/x86_64-linux-gnu/pkgconfig/libbcc.pc
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbpf.h -O /usr/include/bcc/libbpf.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/perf_reader.h -O /usr/include/bcc/perf_reader.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/bcc_version.h -O /usr/include/bcc/bcc_version.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc_bpf.so.0.28.0 -O /usr/lib/x86_64-linux-gnu/libbcc_bpf.so.0.28.0
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc_bpf.so.0 -O /usr/lib/x86_64-linux-gnu/libbcc_bpf.so.0
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/libbcc_bpf.so -O /usr/lib/x86_64-linux-gnu/libbcc_bpf.so
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/BPF.h -O /usr/include/bcc/BPF.h
sudo wget https://ebpfsa.blob.core.windows.net/test-storage/BPFTable.h -O /usr/include/bcc/BPFTable.h


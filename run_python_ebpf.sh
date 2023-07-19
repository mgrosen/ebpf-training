chmod +x ./run_python_ebpf.sh
sudo python3 python_ebpf/final_code_eBPF_dns.py &
curl -i https://google.com
sleep 3600

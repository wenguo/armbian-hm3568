#!/bin/bash
echo "install ntp"
sudo apt-get remove systemd-timesyncd
sudo apt-get install ntp ntpstat

echo "請輸入數字1或者2"
echo "1: 作爲ntp服務器  2:作爲ntp客戶端"
read choice
if [ $choice == "1" ];then
      sudo cp ntp_server.conf /etc/ntp.conf
elif [ $choice == "2" ];then
      echo "請輸入ntp服務器的ip地址"
      read ip      
      cp ntp_client.conf ntp_client.conf.1
      sed "s|server_linux|server $ip|" ntp_client.conf > ntp_client.conf.1
      sudo cp ntp_client.conf.1 /etc/ntp.conf
      rm ntp_client.conf.1
else
	echo "錯誤的選擇,請重新選擇"
fi

sudo ufw allow from any to any port 123 proto udp
sudo systemctl enable ntp
sudo service ntp restart

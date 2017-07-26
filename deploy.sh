FILE=gamemodes/ZZ-RP.amx
FTP_USER=AES-115726
FTP_PASSWORD=LuisC52!
FTP_HOST=ftp1.dc1.computing.cloud.it
echo Subiendo $file al servidor $FTP_HOST
curl --ftp-create-dirs -T $file -u $FTP_USER:$FTP_PASSWORD ftp://$FTP_HOST/home/zz/gamemodes/$file
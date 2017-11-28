cd  ~/Downloads
sudo yum -y groupinstall "Development Tools"
sudo yum -y install yum-utils yum-builddep python zlib-devel gcc
wget -nc  https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
echo -e "\033[5;32;40m Succesefully Downloaded \033[0m"
#echo "Downloading finished"


echo -e "\033[5;34;40m Extracing \033[0m"
tar -xJf Python-3.6.3.tar.xz
echo -e "\033[5;32;40m Succesefully Extracted \033[0m"
cd Python-3.6.3
sudo ./configure
sudo make 
sudo make altinstall 
which python3 && python3 -V

sudo yum groupinstall "Development Tools"
sudo yum -y install yum-utils yum-builddep python zlib-devel gcc
wget -nc  https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
echo "Downloading finished"
mv Python-3.6.3.tar.xz ~/Downloads
cd  ~/Downloads
echo "Extracking"
tar -xJf Python-3.6.3.tar.xz
echo "Extracking Done"
cd Python-3.6.3
./configure
sudo make
sudo make altinstall
which python3 && python3 -V

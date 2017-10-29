
cd  ~/Downloads
wget -nc http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum localinstall  nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum install xrdp tigervnc-server -y

sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-port=3389/tcp
sudo firewall-cmd --reload
sudo chcon --type=bin_t /usr/sbin/xrdp
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman
sudo systemctl start xrdp.service


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
  
fi


yum install bind* -y
RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[34;5;11m"
read -p "$(echo -e $BOLD$YELLOW"Enter your ip address :"$RESET)" ipaddress

#read -p "Enter the ip address :" ipaddress
read -p "$(echo -e $BOLD$YELLOW"Enter your DomainName "$RESET)" domainname
#read -p "Enter your domain.name:" domainname
masud=$(echo $ipaddress | awk -F. '{print $3"."$2"."$1".in-addr.arpa"}')

cat <<EOF >> /var/named/${domainname}.fz

\$TTL 1D
@       IN SOA  @ rname.invalid. (
					0	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	IN NS	 dns1.${domainname}.
	IN A	 $ipaddress
dns1    IN A     $ipaddress


EOF

cat <<EOF >>/var/named/${domainname}.rz
\$TTL 1D
@	IN SOA	@ rname.invalid. (
					0	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	IN NS	dns1.${domainname}.
	IN A	$ipaddress

11	IN PTR	dns1.${domainname}.

EOF

cat <<EOF >>/etc/named.rfc1912.zones
zone $domainname IN {
        type master;
        file "${domainname}.fz";
        allow-update { none; };
};
EOF


cat <<EOF >>/etc/named.rfc1912.zones

zone "$masud" IN {
        type master;
        file "${domainame}.rz";
        allow-update { none; };
};




EOF


chgrp named /var/named/${domainname}.fz
chgrp named /var/named/${domainname}.rz

sed "/listen-on port/c  listen-on port 53 {$ipaddress; };" /etc/named.conf > /etc/named/hoice.conf






yum install bind* -y
read -p "Enter the ip address :" ipaddress

read -p "Enter your domain.name:" domainname
masud=$(echo $ipaddress | awk -F. '{print $3"."$2"."$1".in-addr.arpa"}')

cat <<EOF >> named/${domainname}.fz

N SOA	@ rname.invalid. (
					0	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	IN NS	 dns1.${domainname}.
	IN A	 $ipaddress
dns1    IN A     $ipaddress


EOF

cat <<EOF >>named/${domainname}.rz
$TTL 1D
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

cat <<EOF >>rfc.zones
zone $domainname IN {
        type master;
        file "${domainname}.fz";
        allow-update { none; };
};
EOF


cat <<EOF >>rfc.zones

zone "$masud" IN {
        type master;
        file "${domainame}.rz";
        allow-update { none; };
};


EOF
chgrp named named/${domainname}.fz
chgrp named named/${domainname}.rz

function usage(){
	printf "./vpn command\n"
	printf "\t--up \tUp.\n"
	printf "\t--down \tDown.\n"
}

if [ $# -eq 0 ]
then
	usage
fi

VPN_NAME="vpn_fac"
VPN_SERVER_IP="srv-dpi-vpn.univ-rouen.fr"
VPN_PSK="ZqYP3Dmex09aqc0UIJ0I"
VPN_IPSEC_PSK="0s$(echo -n $VPN_PSK | base64)"
VPN_USER="nomprenom"
VPN_PASSWORD_FLAG=2
VPN_PASSWORD=""

function up() {
	nmcli connection delete $VPN_NAME
	nmcli connection add connection.id $VPN_NAME con-name $VPN_NAME type VPN vpn-type l2tp ifname -- connection.autoconnect no ipv4.method auto vpn.data "gateway = $VPN_SERVER_IP, ipsec-enabled = yes, ipsec-esp = aes128-sha1, ipsec-ike = aes256-sha1-modp2048, ipsec-psk = $VPN_IPSEC_PSK, password-flags = $VPN_PASSWORD_FLAG, user = $VPN_USER" vpn.secrets password=$VPN_PASSWORD
	
	nmcli connection up $VPN_NAME
}

function down() {
	nmcli connection down $VPN_NAME
}

OPTS=$(getopt -o h -l up,down, -- "$@")
if [ $? != 0 ]
then
  	exit 1
fi
eval set -- "$OPTS"
while true ; do
  case "$1" in
  	--up)
			up;
  		shift;;
  	--down)
			down;
  		exit 0;;
		--) shift; break;;
  	esac
done


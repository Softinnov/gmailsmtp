#!/bin/bash

set -e

domain=`echo $user | cut -s -d'@' -f 2`

[[ -z $user ]]   && echo "missing user env var" && exit -1
[[ -z $pass ]]   && echo "missing pass env var" && exit -2
[[ -z $domain ]] && echo "could not extract domain from user, prolly missing the '@'." && exit -3

echo "User:   $user"
echo "Domain: $domain"

echo $domain > /etc/mailname

echo -e "
biff = no
append_dot_mydomain = no
recipient_delimiter = +
inet_interfaces = all
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_path = smtpd
smtp_sasl_password_maps = hash:/etc/postfix/saslpass
smtp_sasl_auth_enable = yes
smtp_cname_overrides_servername = no
smtp_sasl_security_options = noanonymous
smtp_tls_CApath = /etc/ssl/certs
smtp_use_tls = yes
" > /etc/postfix/main.cf

echo "[smtp.gmail.com]:587 $user:$pass" \
	>> /etc/postfix/saslpass

postmap /etc/postfix/saslpass
service postfix start
touch /fake_loop
tail -f /fake_loop

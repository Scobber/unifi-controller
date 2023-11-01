apt update && apt upgrade -y
apt install -y --no-install-recommends software-properties-common curl wget gnupg gpg tzdata
#echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
#wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc |  gpg --dearmour -
#wget -o /etc/apt/trusted.gpg.d/mongodb-org-4.4.asc https://www.mongodb.org/static/pgp/server-4.4.asc
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc |  gpg --dearmour -o /etc/apt/trusted.gpg.d/mongodb-org-4.4.gpg
echo "deb http://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
#curl -sSL https://dl.ui.com/unifi/unifi-repo.gpg -o /etc/apt/trusted.gpg.d/unifi-repo.gpg
#wget http://security.debian.org/debian-security/pool/updates/main/g/glibc/multiarch-support_2.28-10+deb10u2_amd64.deb
#wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
#wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
#add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/


#dpkg -i multiarch-support_2.28-10+deb10u2_amd64.deb
#dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
#rm *.deb

apt update

while read line; do apt-get install -y  $line; sleep 2; done < /dep/depends.apt
apt clean && rm -R /var/lib/apt/lists/*

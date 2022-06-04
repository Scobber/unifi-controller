apt update
apt install -y software-properties-common curl wget gnupg gpg
#echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc |  apt-key add -
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
#curl -sSL https://dl.ui.com/unifi/unifi-repo.gpg -o /etc/apt/trusted.gpg.d/unifi-repo.gpg
wget http://ftp.us.debian.org/debian/pool/main/g/glibc/multiarch-support_2.28-10_amd64.deb
wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.9_amd64.deb
#wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
#add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/


dpkg -i multiarch-support_2.28-10_amd64.deb
dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.9_amd64.deb
rm *.deb

apt update
while read line; do apt-get install -y  $line; done < /dep/depends.apt
apt clean && rm -R /var/lib/apt/lists/*

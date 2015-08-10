#/usr/bin/env bash

# install dependencies
apt-get install -y gedit
apt-get install -y software-properties-common python-software-properties
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y -q install oracle-java8-installer
update-java-alternatives -s java-8-oracle
if [ ! -d /home/vagrant/zookeeper-3.4.6/ ]; then
	wget http://mirrors.ibiblio.org/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
	tar -xvf zookeeper-3.4.6.tar.gz
	cp /vagrant/zoo.cfg zookeeper-3.4.6/conf/
fi
# create log dir - if needed
if [ ! -d /var/lib/zookeeper ]; then
	sudo mkdir -p /var/lib/zookeeper
	sudo chown -R vagrant:vagrant /var/lib/zookeeper
	echo "1" > /var/lib/zookeeper/myid
fi

sudo add-apt-repository -y ppa:chris-lea/zeromq
sudo add-apt-repository -y ppa:chris-lea/libpgm
sudo apt-get update
#Make sure required packages are installed
sudo apt-get install -y libtool pkg-config build-essential autoconf automake
sudo apt-get install -y libzmq-dev
sudo apt-get install -y python3
sudo apt-get install -y git
cd
#LibSodium should also be installed
if [ ! -d /home/vagrant/libsodium/ ]; then
	git clone git://github.com/jedisct1/libsodium.git
	cd /home/vagrant/libsodium
	./autogen.sh
	./configure && make check
	sudo make install
	sudo ldconfig
fi
#zeroMQ
if [ ! -d /home/vagrant/zeromq-4.1.2/ ]; then
	cd /home/vagrant
	wget http://download.zeromq.org/zeromq-4.1.2.tar.gz
	tar -xvf zeromq-4.1.2.tar.gz
	cd /home/vagrant/zeromq-4.1.2
	./autogen.sh
	./configure && make check
	sudo make install
	sudo ldconfig
fi
#Java bind for zeroMQ
if [ ! -d /home/vagrant/jzmq/ ]; then
	cd /home/vagrant
	git clone https://github.com/zeromq/jzmq.git
	cd /home/vagrant 
	./autogen.sh
	./configure
	make
	sudo make install
fi
if [ ! -d /app/home/storm/ ]; then
	sudo groupadd -g 53001 storm
	sudo mkdir -p /app/home
	sudo mkdir -p /app/home/storm
	sudo useradd -u 53001 -g 53001 -d /app/home/storm -s /bin/bash storm -c "Storm service account"
	sudo chmod 700 /app/home/storm
fi
#sudo cp -r /vagrant/jdk-8u* /usr/local/java
#cd /usr/local/java
#sudo tar -xvzf jdk-8u*
#sudo gedit /etc/profile
#JAVA_HOME=/usr/local/java/jdk1.8.0_20
#JRE_HOME=$JAVA_HOME/jre
#PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
#export JAVA_HOME
#export JRE_HOME
#export PATH

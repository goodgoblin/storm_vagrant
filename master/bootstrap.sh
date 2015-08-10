#/usr/bin/env bash

# install dependencies
apt-get install -y gedit
apt-get install -y software-properties-common python-software-properties
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y -q install oracle-java8-installer
update-java-alternatives -s java-8-oracle
wget http://mirrors.ibiblio.org/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
tar -xvf zookeeper-3.4.6.tar.gz

# create log dir - if needed
if [ ! -d /var/lib/zookeeper ]; then
	sudo mkdir -p /var/lib/zookeeper
	sudo chown -R vagrant:vagrant /var/lib/zookeeper
	echo "1" > /var/lib/zookeeper/myid
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

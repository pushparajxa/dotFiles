#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -Uz compinit && compinit -i
fpath=(~/.zsh/completion $fpath)
promptinit
prompt zefram

### Add aliases
alias Tomcat='cd ~/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1'
alias did="vim +'normal Go' +'r!date' ~/did.txt"

bindkey '^Xp' history-beginning-search-backward
bindkey '^Xn' history-beginning-search-backward
bindkey '^X^N' accept-and-infer-next-history
#accept-line-and-down-history
bindkey '^[[1;2A' history-substring-search-up
bindkey '^[[1;2B' history-substring-search-down
bindkey '^[OA'    up-line-or-history
bindkey '^[OB'    down-line-or-history
export AIRFLOW_HOME=~/airflow
export LIBNDBPATH="/Users/pushparaj.motamari/Desktop/ubuntu/github/mysql-cluster-gpl-7.4.11-osx10.11-x86_64/lib"
export DYLD_LIBRARY_PATH="/usr/lib;/Users/pushparaj.motamari/Desktop/ubuntu/github/mysql-cluster-gpl-7.4.11-osx10.11-x86_64/lib"
#Add python to the path
PATH=/Users/pushparaj/Library/Python/2.7/bin:$PATH
#Add mysql to the path
PATH=/usr/local/Cellar/mysql/5.7.22/bin:$PATH
PATH=/usr/local/Cellar/mysql/5.7.22/support-files:$PATH
#Add mongodb to the path
PATH=/usr/local/Cellar/mongodb/3.6.4/bin:$PATH
#Add zook-keeper to the path
PATH=/usr/local/bin/zkServer:$PATH
#Adding Tomcat to the path
PATH=/Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/bin/:$PATH
#Adding ack to the classpath
PATH=/usr/local/bin/ack:$PATH
#Export PATH
export PATH
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Customize to your needs...
catstart(){
pw=`pwd`
	echo "##Starting catalina"
cd /Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/bin
./catalina.sh start
cd $pw
}

catstop(){
pw=`pwd`
echo "##Stopping catalina"
cd /Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/bin
./catalina.sh stop
cd $pw
}

catdebug(){
echo "#Starting catalina in debug mode"
cd /Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/bin
./catalina.sh jdpa start
}

deploy(){
	pw=`pwd`
cd /Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/webapps/
echo "Removing rivigo-zoom.war file"
rm -rf rivigo-zoom.war rivigo-zoom/
echo "Building zoom-commons"
cd /Users/pushparaj/Desktop/code/zoom-commons/ 
mvn clean install
echo "Building zoom-backend"
cd /Users/pushparaj/Desktop/code/zoom-backend/ 
mvn clean install -DskipTests
echo "Copying rivigo-zoom.war file"
cp /Users/pushparaj/Desktop/code/zoom-backend/rivigo-zoom/target/rivigo-zoom.war /Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/webapps/
echo "Restarting Catalina"
cd /Users/pushparaj/Desktop/Rivigo/TomCat/apache-tomcat-8.0.1/bin
./catalina.sh stop
./catalina.sh start
cd $pw
echo "done"
}
export PATH="/usr/local/opt/openssl/bin:$PATH"

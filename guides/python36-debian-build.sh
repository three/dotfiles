apt-get install libsqlite3-dev libreadline-dev libssl-dev libz-dev gcc make git
cd /usr/local/src
wget https://www.python.org/ftp/python/3.6.X/Python-3.6.X.tgz
tar -xf Python-3.6.X.tgz
cd Python-3.6.X
./configure --enable-loadable-sqlite-extensions --enable-optimizations
make
make altinstall

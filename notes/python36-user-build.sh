mkdir -p $HOME/local/src
cd $HOME/local/src
wget https://www.sqlite.org/2018/sqlite-autoconf-3220000.tar.gz
tar -xf sqlite-autoconf-3220000.tar.gz
cd sqlite-autoconf-3220000
./configure --prefix=$HOME/local
make
make install
wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar -xf Python-3.6.4.tgz
cd Python-3.6.4
./configure --enable-loadable-sqlite-extensions --prefix=$HOME/local
make
make altinstall

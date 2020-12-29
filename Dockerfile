FROM ubuntu

RUN apt update; \
    DEBIAN_FRONTEND=noninteractive apt install -y build-essential git gcc g++ make libffi-dev libssl-dev tcl; \
    cd /root; \
    git clone https://github.com/sqlcipher/sqlcipher.git; \
    mkdir bld; \
    cd bld; \
    ../sqlcipher/configure --enable-tempstore=yes CFLAGS="-DSQLITE_HAS_CODEC" LDFLAGS="-lcrypto"; \
    make; make install; \
    apt remove -y build-essential git gcc g++ make libffi-dev libssl-dev tcl; \
    apt autoremove -y; \
    rm -rf ~/bld ~/sqlcipher

ENTRYPOINT ["sqlcipher"]

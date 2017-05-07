#!/bin/bash -e

install -m 644 files/couchdb.service ${ROOTFS_DIR}/etc/systemd/system/couchdb.service

rm -rf ${ROOTFS_DIR}/tmp/couchdb
install -d ${ROOTFS_DIR}/tmp/couchdb

on_chroot <<EOF
  cd /tmp/couchdb && \
  wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc && \
  apt-key add erlang_solutions.asc && \
  apt-get update && \
  apt-get install -y erlang-nox erlang-dev erlang-reltool && \
  apt-get install -y build-essential && \
  apt-get install -y libmozjs185-1.0 libmozjs185-dev && \
  apt-get install -y libcurl4-openssl-dev libicu-dev && \
  \
  useradd -d /home/couchdb couchdb; \
  mkdir /home/couchdb;  \
  chown couchdb:couchdb /home/couchdb &&\
  \
  wget http://www.gtlib.gatech.edu/pub/apache/couchdb/source/2.0.0/apache-couchdb-2.0.0.tar.gz && \
  tar zxvf apache-couchdb-2.0.0.tar.gz && \
  cd apache-couchdb-2.0.0/ && \
  ./configure && \
  make release && \
  \
  sed -i 's/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/' /tmp/couchdb/apache-couchdb-2.0.0/rel/couchdb/etc/local.ini &&
  \
  mkdir /opt/couchdb; \
  cp -Rp /tmp/couchdb/apache-couchdb-2.0.0/rel/couchdb/* /opt/couchdb && \
  chown -R couchdb:couchdb /opt/couchdb && \
  \
  rm -rf /tmp/couchdb && \
  \
  systemctl enable couchdb.service
EOF

# TODO REVIEW -->> http://docs.couchdb.org/en/2.0.0/install/unix.html

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Download and install the public signing key"
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

echo "Copy Elasticsearch repo"
cp "$SCRIPT_DIR/elasticsearch.repo" /etc/yum.repos.d/elastic.repo

echo "Install Elasticsearch"
dnf install -y --enablerepo=elasticsearch elasticsearch

echo "Start Elasticsearch"
systemctl daemon-reload
systemctl enable elasticsearch
systemctl restart elasticsearch

echo "Elasticsearch installation completed."

echo "Install Kibana"
dnf install -y --enablerepo=elasticsearch kibana

echo "Copy kibana yml"
cp "$SCRIPT_DIR/kibana.yml" /etc/kibana/kibana.yml

echo "Start Elasticsearch"
systemctl daemon-reload
systemctl enable kibana
systemctl restart kibana

echo "kibana installation completed."

echo "Install logstash"
dnf install -y --enablerepo=elasticsearch logstash

echo "Copy logstash conf"
cp "$SCRIPT_DIR/logstash.conf" /etc/logstash/logstash.conf

echo "Start Logstash"
systemctl daemon-reload
systemctl enable logstash
systemctl restart logstash

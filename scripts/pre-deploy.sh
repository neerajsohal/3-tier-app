#!/bin/bash

# Identify the OS
if [ -f /etc/debian_version ]; then
    OS=debian
elif [ -f /etc/redhat-release ]; then
    OS=redhat
else
    echo "Unsupported OS"
    exit 1
fi

echo "Identified OS: $OS"

if [ "$OS" = "debian" ]; then
    apt-get install -y python-mysqldb python-flask libapache2-mod-wsgi
fi

if [ "$OS" = "redhat" ]; then
    yum -y install MySQL-python python-pip mod_wsgi

    easy_install pip
    pip install flask  # Outdated flask in the packages

    # Configure mod_wsgi to use a writabe location
    echo "WSGISocketPrefix /var/run/wsgi" > /etc/httpd/conf.d/webapp.conf
fi

# Remove pre-existing install
rm -rf %remote_path%

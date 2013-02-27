#!/bin/bash
# Install/update DSpace from source, with Laurentian customizations


# Prerequisites:
# 1. Download DSpace source to a directory whose path is defined in DSPACE_SRC
# 2. Backup the /dspace/assetstore directory, and the database. Define
#    location/file name in DSPACE_DB_BACKUP and ASSETSTORE_BACKUP respectively
# 3. Download Laurentian customizations & link to DSpace source tree
#
#    Steps 2&3 can be done by forking github.com/kbeswick/lu-zone, then:
#
#  ln -s lu-zone/config /path/to/dspace/src/dspace/config
#  ln -s lu-zone/modules/jspui /path/to/dspace/src/dspace/modules/jspui
#
#
# DISCLAIMER:
#
# This script is currently intended as more of a guide, rather than an automation of
# the installation process, although under the right conditions it should work.



DSPACE_SRC='/path/to/dspace/src'
DSPACE_DB_BACKUP='dspace_database.dump'
ASSETSTORE_BACKUP='/path/to/assetstore'

cd ${DSPACE_SRC}/dspace/

# Build a clean version of DSpace
mvn -U clean package

# Stop Tomcat, remove the old version of DSpace
sudo /etc/init.d/tomcat6 stop
sudo rm -Rf /dspace

# Delete and create empty database for fresh DSpace install
sudo su -c "dropdb dspace ; createdb -U dspace -E UNICODE dspace" postgres

# Install DSpace
cd target/dspace-3.0-build/
sudo ant fresh_install

# Copy over the backed up assetstore
sudo rm -Rf /dspace/assetstore
sudo cp -R ${ASSETSTORE_BACKUP} /dspace/

# Recreate the database with backed up version
sudo su -c "cd /var/lib/postgresql && dropdb dspace && createdb -U dspace -E UNICODE dspace && psql dspace < ${DSPACE_DB_BACKUP}" postgres

# Do database upgrades
#psql -U dspace dspace < ${DSPACE_SRC}/dspace/etc/postgres/database_schema_17-18.sql
#psql -U dspace dspace < ${DSPACE_SRC}/dspace/etc/postgres/database_schema_18-3.sql

# Be consistent with our previous DSpace URLS
sudo ln -s /dspace/webapps/oai /dspace/webapps/dspace-oai
sudo ln -s /dspace/webapps/jspui /dspace/webapps/dspace

# Set permissions for /dspace
sudo chown -R tomcat6:root /dspace

# Prepare the indexes, media
sudo /dspace/bin/dspace index-init
sudo /etc/init.d/tomcat6 start
sudo /dspace/bin/dspace filter-media
sudo /dspace/bin/dspace oai import -o

# Done
echo "----------------------"
echo "Done installing DSpace..."


#!/bin/bash --
#####################################
# The script creates a PKI for 
# test, using OpenSSL
#
# Last updated 20130222 by N. Shang
#####################################


# Create new directories
mkdir -p TestCA/private
mkdir -p TestCA/newcerts
mkdir -p TestCA/server
echo '01' >TestCA/serial
touch TestCA/index.txt

# Some file paths

ROOT_DIR=./TestCA
CACERT_PATH=$ROOT_DIR/cacert.pem
CAKEY_PATH=$ROOT_DIR/private/cakey.pem
SERVER_HOSTNAME=example.com
SERVER_CERT_REQUEST_PATH=$ROOT_DIR/server/$SERVER_HOSTNAME.csr
SERVER_KEY_PATH=$ROOT_DIR/server/$SERVER_HOSTNAME.key
SERVER_CERT_PATH=$ROOT_DIR/server/$SERVER_HOSTNAME.cert.pem

# Create CA certificate and the private key
# At prompt, enter the following information
#
# Country Name (2 letter code) [AU]:US
# State or Province Name (full name) [Some-State]:California
# Locality Name (eg, city) []:San Diego
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:AB
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []:AB Certificate Authority
# Email Address []:
#

openssl req -nodes -newkey rsa:4096 -x509 -extensions v3_ca \
-keyout $CAKEY_PATH -out $CACERT_PATH -config ./openssl.cnf

# Create certificate request
# At prompt, enter the following information
#
# Country Name (2 letter code) [AU]:US
# State or Province Name (full name) [Some-State]:California
# Locality Name (eg, city) []:San Diego
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:AB
# Organizational Unit Name (eg, section) []:AB
# Common Name (e.g. server FQDN or YOUR name) []:*.example.com
# Email Address []:
#
# Please enter the following 'extra' attributes
# to be sent with your certificate request
# A challenge password []:
# An optional company name []:
#

openssl req -nodes -newkey rsa:2048 -extensions v3_req \
-keyout $SERVER_KEY_PATH \
-out $SERVER_CERT_REQUEST_PATH -config ./openssl.cnf

# Sign the certificate request to create TLS server certificate
openssl ca -out $SERVER_CERT_PATH -extensions v3_req \
-config ./openssl.cnf  \
-infiles $SERVER_CERT_REQUEST_PATH 

# Output some info
echo "++++++++++++++++++++++++++++++++++++++"
echo "CA certificate: $CACERT_PATH"
echo "Server certificate: $SERVER_CERT_PATH"
echo "++++++++++++++++++++++++++++++++++++++"
echo "Please keep the following keys secure:"
echo ""
echo "CA private key: $CAKEY_PATH"
echo "Server private key: $SERVER_KEY_PATH"
echo "++++++++++++++++++++++++++++++++++++++"


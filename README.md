# create-pki: a simple script demonstrating how to create a public-key infrastructure for a TLS server

# How to generate a PKI

* Modify the configuration template file `openssl.conf` as needed. 
* Run `./create_pki.sh` to generate a TLS server certificate. Enter requested
  information when prompted.

# How to test the server certificate

## Server-side test

Run
```
openssl s_server \
-CAfile TestCA/cacert.pem \
-cert TestCA/server/example.com.cert.pem \
-key TestCA/server/example.com.key 
```
If everything is OK, expect to see
```
Using default temp DH parameters
Using default temp ECDH parameters
ACCEPT
```
## Client-side test

In another shell, try
```	
openssl s_client
```

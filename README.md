# create-pki: a simple script demonstrating how to create a public-key infrastructure for a TLS server

# Dependency
The script has been tested on Ubuntu (e.g., 16.04 LTS), and  requires 
OpenSSL be installed. To install OpenSSL on Ubuntu, 
```
sudo apt-get install openssl
```


# How to generate a PKI

* Modify the configuration template file `openssl.conf` as needed. 
* Run `./create_pki.sh` to generate a TLS server certificate. Enter requested
  information when prompted.
* To add a subjectAltName, in [openssl.cnf](./openssl.cnf), under the `[
  v3_req]` section, uncomment the line
  ```
  subjectAltName = DNS:<your_subject_alternative_name>
  ```
  and replace the `<your_subject_alternative_name>` with your SAN.

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

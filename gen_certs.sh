#!/bin/bash

set -e

## Create the root CA certificate and key using 
openssl req -config gen_rootCa_cert.conf  -new -x509  -keyout rootCa.key  -out rootCa.crt  -days 3650


## Generate public/private key pair and keystore for each node
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.101  -keystore 192.168.56.101.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.101, OU=LocalCluster, O=AIB, C=IR"
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.102  -keystore 192.168.56.102.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.102, OU=LocalCluster, O=AIB, C=IR"
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.103  -keystore 192.168.56.103.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.103, OU=LocalCluster, O=AIB, C=IR"
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.201  -keystore 192.168.56.201.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.201, OU=LocalCluster, O=AIB, C=IR"
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.202  -keystore 192.168.56.202.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.202, OU=LocalCluster, O=AIB, C=IR"
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.203  -keystore 192.168.56.203.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.203, OU=LocalCluster, O=AIB, C=IR"
keytool -genkeypair  -keyalg RSA  -alias 192.168.56.221  -keystore 192.168.56.221.jks  -storepass changeit  -keypass changeit  -validity 3650  -keysize 2048  -dname "CN=192.168.56.221, OU=LocalCluster, O=AIB, C=IR"


## Export certificate signing request (CSR) for each node
keytool -certreq -keystore  192.168.56.101.jks  -alias 192.168.56.101  -file 192.168.56.101.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.101, OU=LocalCluster, O=AIB, C=IR"
keytool -certreq -keystore  192.168.56.102.jks  -alias 192.168.56.102  -file 192.168.56.102.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.102, OU=LocalCluster, O=AIB, C=IR"
keytool -certreq -keystore  192.168.56.103.jks  -alias 192.168.56.103  -file 192.168.56.103.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.103, OU=LocalCluster, O=AIB, C=IR"
keytool -certreq -keystore  192.168.56.201.jks  -alias 192.168.56.201  -file 192.168.56.201.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.201, OU=LocalCluster, O=AIB, C=IR"
keytool -certreq -keystore  192.168.56.202.jks  -alias 192.168.56.202  -file 192.168.56.202.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.202, OU=LocalCluster, O=AIB, C=IR"
keytool -certreq -keystore  192.168.56.203.jks  -alias 192.168.56.203  -file 192.168.56.203.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.203, OU=LocalCluster, O=AIB, C=IR"
keytool -certreq -keystore  192.168.56.221.jks  -alias 192.168.56.221  -file 192.168.56.221.csr  -keypass changeit  -storepass changeit  -dname "CN=192.168.56.221, OU=LocalCluster, O=AIB, C=IR"


## Sign node certificate with rootCa for each node
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.101.csr  -out 192.168.56.101.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.102.csr  -out 192.168.56.102.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.103.csr  -out 192.168.56.103.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.201.csr  -out 192.168.56.201.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.202.csr  -out 192.168.56.202.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.203.csr  -out 192.168.56.203.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit
openssl x509  -req  -CA rootCa.crt  -CAkey rootCa.key  -in 192.168.56.221.csr  -out 192.168.56.221.crt_signed  -days 3650  -CAcreateserial  -passin pass:changeit



## Verify the signed certificate for each node
openssl verify -CAfile rootCa.crt 192.168.56.101.crt_signed
openssl verify -CAfile rootCa.crt 192.168.56.102.crt_signed
openssl verify -CAfile rootCa.crt 192.168.56.103.crt_signed
openssl verify -CAfile rootCa.crt 192.168.56.201.crt_signed
openssl verify -CAfile rootCa.crt 192.168.56.202.crt_signed
openssl verify -CAfile rootCa.crt 192.168.56.203.crt_signed
openssl verify -CAfile rootCa.crt 192.168.56.221.crt_signed



## Import rootCa certificate to each node keystore
keytool -importcert  -keystore 192.168.56.101.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit
keytool -importcert  -keystore 192.168.56.102.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit
keytool -importcert  -keystore 192.168.56.103.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit
keytool -importcert  -keystore 192.168.56.201.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit
keytool -importcert  -keystore 192.168.56.202.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit
keytool -importcert  -keystore 192.168.56.203.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit
keytool -importcert  -keystore 192.168.56.221.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit


## Import node's signed certificate into node keystore for each node
keytool -importcert -keystore 192.168.56.101.jks  -alias 192.168.56.101  -file 192.168.56.101.crt_signed  -noprompt  -keypass change  -storepass changeit
keytool -importcert -keystore 192.168.56.102.jks  -alias 192.168.56.102  -file 192.168.56.102.crt_signed  -noprompt  -keypass change  -storepass changeit
keytool -importcert -keystore 192.168.56.103.jks  -alias 192.168.56.103  -file 192.168.56.103.crt_signed  -noprompt  -keypass change  -storepass changeit
keytool -importcert -keystore 192.168.56.201.jks  -alias 192.168.56.201  -file 192.168.56.201.crt_signed  -noprompt  -keypass change  -storepass changeit
keytool -importcert -keystore 192.168.56.202.jks  -alias 192.168.56.202  -file 192.168.56.202.crt_signed  -noprompt  -keypass change  -storepass changeit
keytool -importcert -keystore 192.168.56.203.jks  -alias 192.168.56.203  -file 192.168.56.203.crt_signed  -noprompt  -keypass change  -storepass changeit
keytool -importcert -keystore 192.168.56.221.jks  -alias 192.168.56.221  -file 192.168.56.221.crt_signed  -noprompt  -keypass change  -storepass changeit

## Create a server truststore
## A server truststore file can be used to establish a chain of trust between the nodes of the cluster
keytool -importcert  -keystore server-truststore.jks  -alias rootCa  -file rootCa.crt  -noprompt  -keypass changeit  -storepass changeit

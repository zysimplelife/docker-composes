This example is about using PAM + LDAP with non-root user. docker-compose file contains two service, open ldap and pam client, which is ubuntu based. nslcd is chosen instead of sssd which has hard cord for root user. The drawback of not using sssd is missing local cache, so if there are network connection outage, authentication won't work until network comes back. To create a user that can be used in PAM, user needs to add a user object in open ldap service under dn "dc=example,dc=org" manually, there is a ldif file example avaiable in this example. Please follow steps below to run this example.

* Start Service
```bash
#the client image is from Dockerfile
docker-compose up -d --build
```

* Import User
```bash
docker-compose exec  open-ldap ldapadd -x -D "cn=admin,dc=example,dc=org" -w admin -H ldap:// -f /workspace/ldif/user1.ldif
```

* Check connection
```bash
#myuser should be listed in the output
getent passwd

#run pam client to test authentication process
/check_user
```

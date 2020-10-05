FROM phusion/baseimage:bionic-1.0.0
RUN apt-get update && apt-get install -qqy nslcd sudo-ldap ca-certificates docker.io
ADD nslcd.conf /etc/nslcd.conf
ADD ldap.conf /etc/ldap/ldap.conf
ADD nsswitch.conf /etc/nsswitch.conf
ADD common-session /etc/pam.d/common-session
ADD rc.local /etc/rc.local

CMD /sbin/my_init



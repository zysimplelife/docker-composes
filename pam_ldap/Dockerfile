FROM phusion/baseimage:bionic-1.0.0

RUN apt-get update && apt-get install -qqy nslcd sudo-ldap ca-certificates docker.io

ADD nslcd.conf /etc/nslcd.conf
#ADD ldap.conf /etc/ldap.conf
ADD nsswitch.conf /etc/nsswitch.conf
ADD common-session /etc/pam.d/common-session
ADD check /etc/pam.d/check
ADD rc.local /etc/rc.local
ADD user_checker /user_checker


env USER=appuser
RUN groupadd -r $USER &&\
    useradd -r -g $USER -d /home/$USER  -c "Docker image user" $USER
RUN chown $USER /etc/nslcd.conf
RUN chown $USER /etc/nsswitch.conf
#RUN chown $USER /etc/ldap.conf
RUN chown $USER /user_checker
RUN chown $USER /var/run/nslcd
RUN mkdir /var/run/nscd
RUN chown $USER /var/run/nscd


USER $USER

CMD nslcd -d



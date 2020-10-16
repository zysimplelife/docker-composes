FROM phusion/baseimage:bionic-1.0.0

RUN apt-get update && apt-get install -qqy nslcd sudo-ldap ca-certificates docker.io

ADD nslcd.conf /etc/nslcd.conf
ADD nsswitch.conf /etc/nsswitch.conf
ADD common-session /etc/pam.d/common-session
ADD check /etc/pam.d/check
ADD rc.local /etc/rc.local
ADD user_checker /user_checker


env USER=appuser
#docker compose doesn't support suplimentory user group, so need create another user with group 0 to simular openshift. 
env USER2=appuser2
env GROUP=0

RUN useradd -r -g 0 -d /home/$USER2  -c "Docker image user" $USER2
RUN groupadd -r $USER &&\
    useradd -r -g $USER -d /home/$USER  -c "Docker image user" $USER

RUN chown $USER:$GROUP /etc/nslcd.conf
RUN chown $USER:$GROUP /etc/nsswitch.conf
RUN chown $USER:$GROUP /user_checker
RUN chown $USER:$GROUP /var/run/nslcd
RUN mkdir /var/run/nscd
RUN chown $USER:$GROUP /var/run/nscd

RUN chmod -R 770 /var/run/nslcd
RUN chmod -R 770 /var/run/nscd
RUN chmod 660 /etc/nsswitch.conf
RUN chmod 660 /etc/nslcd.conf

USER $USER

CMD nslcd -d

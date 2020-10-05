FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN chmod 744 /var/run/sshd
RUN echo 'root:password' | chpasswd
COPY sshd_config /etc/ssh/sshd_config

RUN useradd -ms /bin/bash  vault
RUN echo 'vault:password' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


RUN groupadd -r app &&\
    useradd -r -g app -d /home/app  -c "Docker image user" app
RUN echo 'app:password' | chpasswd

ENV HOME=/home/app
ENV APP_HOME=/home/app/sshd
## SETTING UP THE APP ##
RUN mkdir $HOME
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#RUN setcap cap_setuid,cap_setgid,cap_kill,cap_chown+iep /usr/sbin/sshd

## Change
RUN chown -R app:app $APP_HOME
RUN chown -R app:app /etc/ssh/
RUN chown -R app:app /etc/passwd

RUN usermod -a -G shadow app



EXPOSE 2223
CMD ["/usr/sbin/sshd","-ddd" ,"-D"]

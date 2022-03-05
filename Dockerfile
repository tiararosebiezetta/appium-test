FROM budtmo/docker-android-x86-8.1

RUN apt-get update
RUN apt-get install -y git
RUN git clone https://github.com/budtmo/docker-android /root
WORKDIR /root

RUN chmod -R +x /root/src && chmod +x /root/supervisord.conf

HEALTHCHECK --interval=2s --timeout=40s --retries=1 \
    CMD timeout 40 adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'

CMD /usr/bin/supervisord --configuration supervisord.conf

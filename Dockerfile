ARG ALPINE_VERSION="3.21.3"
ARG PYTHON_VERSION="2.7.18"

FROM alpine:${ALPINE_VERSION}

ARG PYTHON_VERSION
ARG ALPINE_VERSION

ARG USERNAME="finder"

ARG BUILD_WORK_DIR="/root/"

WORKDIR ${BUILD_WORK_DIR}

COPY ./docker_init.sh /docker_init.sh

RUN chmod u+x /docker_init.sh                                                                                                   \
    && apk update                                                                                                               \
    && apk upgrade --no-cache                                                                                                   \
    && adduser -D ${USERNAME}                                                                                                   \
    && echo "PS1='\[\033[01;32m\]\u@${ALPINE_VERSION}-vol2\[\033[01;34m\] \w \$\[\033[00m\] '" | tee /home/${USERNAME}/.bashrc  \
    && echo "alias volatility='vol.py'" | tee -a /home/${USERNAME}/.bashrc                                                      \
    && echo "alias vol='vol.py'" | tee -a /home/${USERNAME}/.bashrc                                                             \
    && apk add --no-cache bash                                                                                                  \
                gcc                                                                                                             \
                build-base                                                                                                      \
                git                                                                                                             \
                sudo                                                                                                            \
                nano                                                                                                            \
                wget                                                                                                            \
                ncurses-dev                                                                                                     \
                gdbm-dev                                                                                                        \
                zlib-dev                                                                                                        \
                tk-dev                                                                                                          \
                sqlite-dev                                                                                                      \
                readline-dev                                                                                                    \
                xz-dev                                                                                                          \
                libffi-dev                                                                                                      \
                openssl-dev                                                                                                     \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz                                 \
    && tar -xvf ./Python-${PYTHON_VERSION}.tar.xz                                                                               \
    && cd Python-${PYTHON_VERSION}                                                                                              \
    && ./configure --enable-optimizations                                                                                       \
    && make -j8                                                                                                                 \
    && make -j8 install                                                                                                         \
    && cd ${BUILD_WORK_DIR}                                                                                                     \
    && wget https://bootstrap.pypa.io/pip/2.7/get-pip.py                                                                        \
    && python2 get-pip.py                                                                                                       \
    && pip2 install --upgrade setuptools                                                                                        \
    && pip2 install pycrypto distorm3                                                                                           \
    && cd ${BUILD_WORK_DIR}                                                                                                     \
    && git clone https://github.com/volatilityfoundation/volatility.git                                                         \
    && cd volatility                                                                                                            \
    && python2 setup.py install                                                                                                 \
    && cd /home/${USERNAME}                                                                                                     \
    && git clone https://github.com/volatilityfoundation/community.git                                                          \
    && chmod 700 -R /home/${USERNAME}/community                                                                                 \
    && chown ${USERNAME}:${USERNAME} /home/${USERNAME}/community                                                                \
    && rm -rf ${BUILD_WORK_DIR}/Python-${PYTHON_VERSION}.tar.xz ${BUILD_WORK_DIR}/get-pip.py ${BUILD_WORK_DIR}/volatility       \
    && apk del gcc build-base ncurses-dev gdbm-dev zlib-dev tk-dev sqlite-dev readline-dev xz-dev libffi-dev openssl-dev        \
    && mkdir -p /custom_overlays/windows /custom_overlays/linux /custom_overlays/mac /forensic

WORKDIR /forensic

CMD ["/bin/sh", "-c", "/docker_init.sh"]
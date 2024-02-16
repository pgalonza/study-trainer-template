
FROM ubuntu:23.10

ARG GLOW_VERSION="v1.5.1"
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

RUN apt-get update \
&& apt-get install --no-install-recommends -y curl iproute2 iputils-ping ca-certificates \
python3.11 pipx \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN pipx ensurepath \
&& pipx install pytest-testinfra --include-deps

WORKDIR /opt
RUN curl -LO https://github.com/charmbracelet/glow/releases/download/${GLOW_VERSION}/glow_Linux_x86_64.tar.gz \
&& mkdir ./glow \
&& tar -xzvf glow_Linux_x86_64.tar.gz -C ./glow \
&& cp ./glow/glow /usr/bin/glow

COPY ./tasks/* /course/tasks/
COPY ./scripts/on-login.sh /etc/profile.d/on-login.sh
COPY ./scripts/aliases.sh /course/scripts/
COPY ./scripts/task-*.sh /course/scripts/
COPY ./tasks-test/test_task_*.py /course/tasks-test/

RUN chmod +x /etc/profile.d/on-login.sh \
/course/scripts/* \
&& echo "source /course/scripts/aliases.sh" >> /root/.bashrc

CMD /bin/bash -c "su - root"

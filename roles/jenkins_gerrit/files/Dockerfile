FROM ubuntu:latest

ENV DEBIAN_FRONTEND  "noninteractive"
ENV GERRIT_SITE "/data/gerrit/"
ENV JAVA_HOME "/usr/lib/jvm/java-14-openjdk-amd64/"

RUN mkdir -p /data/gerrit/etc/  /root/.ssh /data/gerrit/plugins

COPY gerrit.config /data/gerrit/etc
COPY secure.config /data/gerrit/etc
COPY entrypoint.sh /
COPY id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa*

RUN apt update -y && apt install -y --no-install-recommends curl  && \
    ln -fs /usr/share/zoneinfo/$(curl https://ipapi.co/timezone) /etc/localtime && \
    apt install -y --no-install-recommends wget \
                                           openssh-server \
                                           git \
                                           tzdata \
                                           openjdk-14-jdk \
                                           nginx \
                                           vim && \
    wget https://gerrit-ci.gerritforge.com/job/plugin-project-download-commands-bazel-master/lastSuccessfulBuild/artifact/bazel-bin/plugins/project-download-commands/project-download-commands.jar -O /data/gerrit/plugins/project-download-commands.jar && \
    wget https://gerrit-ci.gerritforge.com/job/plugin-delete-project-bazel-stable-2.16/lastSuccessfulBuild/artifact/bazel-bin/plugins/delete-project/delete-project.jar -O /data/gerrit/plugins/delete-project.jar && \
    wget https://gerrit-ci.gerritforge.com/job/plugin-webhooks-bazel-stable-2.16/lastSuccessfulBuild/artifact/bazel-bin/plugins/webhooks/webhooks.jar -O /data/gerrit/plugins/webhooks.jar && \
    wget https://gerrit-ci.gerritforge.com/job/plugin-rename-project-bazel-master/lastSuccessfulBuild/artifact/bazel-bin/plugins/rename-project/rename-project.jar -O /data/gerrit/plugins/rename-project.jar

ENTRYPOINT ["/entrypoint.sh"]
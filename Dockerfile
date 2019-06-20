FROM centos:latest
LABEL maintainer "huangshumao"
WORKDIR /opt
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum -y install kde-l10n-Chinese \
    && yum -y reinstall glibc-common \
    && yum update -y \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && export LC_ALL=zh_CN.UTF-8 \
    && echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf \
    && yum clean all \
    && rm -rf /var/cache/yum/*
RUN set -ex \    
    && echo -e "[mariadb]\nname = MariaDB\nbaseurl = http://mirrors.ustc.edu.cn/mariadb/yum/10.4/centos7-amd64\ngpgkey=http://mirrors.ustc.edu.cn/mariadb/yum/RPM-GPG-KEY-MariaDB\ngpgcheck=1" >/etc/yum.repos.d/mariadb.repo \
    && yum install MariaDB-server MariaDB-client -y \
    && yum clean all \
    && rm -rf /var/cache/yum/*

COPY readme.txt readme.txt
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

VOLUME /var/lib/mysql
EXPOSE 3306
ENTRYPOINT ["entrypoint.sh"]




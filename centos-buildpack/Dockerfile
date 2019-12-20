FROM centos:7

ADD https://mirrors.aliyun.com/repo/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y && \
  yum install -y gcc g++ automake cmake autoconf make kernel-devel \
  curl-devel pkgconfig git zsh vim scl-utils centos-release-scl wget

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN yum install -y rh-python36 && \
  source /opt/rh/rh-python36/enable && \
  echo "source /opt/rh/rh-python36/enable" >> /root/.zshrc && \
  pip install -i https://pypi.doubanio.com/simple/ --upgrade pip && \
  pip install -i https://pypi.doubanio.com/simple/ opencv-python

WORKDIR /app

CMD [ "/bin/zsh" ]

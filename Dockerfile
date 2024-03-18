FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git \
build-essential \
gcc \
openjdk-21-jdk \
mono-complete \
python3 \
strace \
valgrind 
RUN useradd -G sudo -m -d /home/alexo -s /bin/bash -p "$(Flopsi12)" alexo
USER alexo
WORKDIR /home/alexo
RUN mkdir hacking \
&& cd hacking \
&& curl -SLhttps://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "alexandrod@uia.no" \
&& git config --global user.name "AlexandrosDimopoulos" \
&& git config --global url."https://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.insteadOf "https://github.com/AlexandrosDimopoulos/sem02v24.git" \
&& mkdir -p github.com/AlexandrosDimopoulos/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.22.1.linux-amd64.tar.gz \
| tar xvz -C /usr/local
USER alexo
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/alexo/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \
| sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"
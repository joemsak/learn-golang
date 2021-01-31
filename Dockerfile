FROM golang:1.14

WORKDIR /go/src/app

COPY . .

RUN mv /go/src/app/vimrc /root/.vimrc

RUN apt update && apt install -y \
  vim

RUN curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

RUN vim +NeoBundleInstall +qall
RUN vim +GoInstallBinaries +qall

RUN go mod init hello
RUN go build .

CMD ["bash"]

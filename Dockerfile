FROM golang:1.14

RUN apt update && apt install -y \
  vim

RUN curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

RUN vim +NeoBundleInstall +qall
RUN vim +GoInstallBinaries +qall

WORKDIR /go/src/app

COPY . .

RUN mv /go/src/app/vimrc /root/.vimrc

RUN go mod init learn-golang
RUN go build .
RUN cd hello && go build

CMD ["bash"]

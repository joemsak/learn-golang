FROM golang:1.14

RUN apt update && apt install -y \
  vim

RUN curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

COPY vimrc /root/.vimrc

RUN vim +NeoBundleInstall +qall
RUN vim +GoInstallBinaries +qall

WORKDIR /go/src/app

COPY . .

RUN rm vimrc
RUN go mod init learn-golang
RUN go build .
RUN cd hello && go build

CMD ["bash"]

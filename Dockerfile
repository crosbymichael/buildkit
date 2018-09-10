FROM golang:1.10.4 as builder

RUN apt-get update && apt-get install -y \
        make \
        libseccomp-dev \
        gcc \
        git \
        btrfs-tools \
        xfsprogs

ADD . /go/src/github.com/moby/buildkit
WORKDIR /go/src/github.com/moby/buildkit

RUN cd cmd/buildkitd && go build -o ../../bin/buildkitd
RUN cd cmd/buildctl && go build -o ../../bin/buildctl

FROM scratch

COPY --from=builder /go/src/github.com/moby/buildkit/bin /bin

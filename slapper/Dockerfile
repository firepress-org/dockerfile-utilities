FROM golang:1.12-alpine3.10 AS builder

RUN set -eux                                                      && \
    apk --update --no-cache add git ca-certificates               && \
    update-ca-certificates

WORKDIR /usr/local/go

# required
RUN go get github.com/nsf/termbox-go && \
    go get github.com/wayneashleyberry/terminal-dimensions

# app
# using git clone to bypass the bug when using go get
RUN git clone https://github.com/ikruglov/slapper && \
    cd slapper && \
    go build

# LAYER compress — — — — — — — — — — — — — — — — — — — — — — — —
FROM alpine:3.11 AS compress
COPY --from=builder /usr/local/go/slapper/slapper /usr/local/go/slapper/slapper
WORKDIR /usr/local/go/slapper
RUN set -eux                                                      && \
    apk --update --no-cache add upx                               && \
    upx --lzma --best slapper                                     && \
    upx -t slapper

###################################################
FROM alpine:3.11 AS final
COPY --from=compress /usr/local/go/slapper/slapper /usr/local/go/slapper/slapper
WORKDIR /usr/local/go/slapper
ENTRYPOINT [ "/usr/local/go" ]
CMD [ "slapper", "-help" ]
FROM golang:1.15 AS builder

WORKDIR /code/

COPY ./go.mod /code/go.mod
COPY ./go.sum /code/go.sum
RUN go mod download

COPY . /code/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ./


FROM debian:stretch

COPY --from=builder /code/module-39 /usr/local/bin/module-39

RUN chmod +x /usr/local/bin/module-39

ENTRYPOINT [ "module-39" ]
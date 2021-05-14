FROM golang:1.16 as builder

WORKDIR /go/src/github.com/smpio/kube-delayed-term-pod-admission/

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags "-s -w"


FROM scratch
COPY --from=builder /go/src/github.com/smpio/kube-delayed-term-pod-admission/kube-delayed-term-pod-admission /
ENTRYPOINT ["/kube-delayed-term-pod-admission"]

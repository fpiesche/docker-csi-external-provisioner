FROM golang:1.20.5-alpine AS builder

RUN apk add --no-cache git make bash && \
  git clone https://github.com/kubernetes-csi/external-provisioner.git /external-provisioner
WORKDIR /external-provisioner
RUN make

FROM scratch
LABEL maintainers="Florian Piesche <florian@yellowkeycard.net>"
LABEL description="Unmodified multi-arch builds of kubernetes-csi/external-provisioner"

COPY --from=builder /external-provisioner/bin/csi-provisioner /csi-provisioner
ENTRYPOINT ["/csi-provisioner"]

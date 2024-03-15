FROM fedora-minimal

RUN microdnf install -y rng-tools && microdnf clean all

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

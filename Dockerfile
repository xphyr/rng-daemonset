FROM fedora

RUN dnf install -y rng-tools

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
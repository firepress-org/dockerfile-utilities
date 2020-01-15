docker run ctr.run/github.com/firepress-org/dockerfile-utilities/slapper:master sh -c \
    "htpasswd -nbB ${USER} ${PW}" | sed -e s/\\$/\\$\\$/g

FROM haproxy:1.8-alpine

COPY container-root/ /

CMD /init

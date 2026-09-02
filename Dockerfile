FROM httpd:alpine
COPY index.html /usr/local/apache2/htdocs/
COPY test.txt /usr/local/apache2/htdocs/

# Rahti runs containers as an arbitrary non-root UID, which can't bind to port 80 —
# move Apache to 8080 instead, and make sure that UID (via group 0) can still write
# Apache's log/pid files.
RUN sed -i 's/^Listen 80$/Listen 8080/' /usr/local/apache2/conf/httpd.conf && \
    chgrp -R 0 /usr/local/apache2/logs && \
    chmod -R g=u /usr/local/apache2/logs
EXPOSE 8080
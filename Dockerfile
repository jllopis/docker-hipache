# VERSION          v0.1.0
# DOCKER-VERSION   0.9.1
# HIPACHE-VERSION  0.2.4
# AUTHOR:          Joan Llopis <jllopis@acb.es>
# DESCRIPTION:     Image with hipache proxy server
# TO_BUILD:        docker build -rm -t jllopis/hipache:{version} .
# TO_RUN:          docker run -p 443 -p 80 --link redis:redis jllopis/hipache:{version}

FROM jllopis/nodejs:0.10.26
MAINTAINER Joan Llopis <jllopisg@gmail.com>

# Install hipache
RUN npm install hipache@0.2.4 -g
ADD ./config.json /usr/local/lib/node_modules/hipache/config/config.json

ENV NODE_ENV production

# Add init script
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/run.sh"]

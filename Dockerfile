# VERSION          v0.1.0
# DOCKER-VERSION   0.9.1
# HIPACHE-VERSION  0.10.26
# AUTHOR:         Joan Llopis <jllopis@acb.es>
# DESCRIPTION:    Image with hipache proxy server
# TO_BUILD:       docker build -rm -t jllopis/hipache:{version} .
# TO_RUN:         docker run -p 6379 -p 80 jllopis/hipache:{version}

FROM jllopis/nodejs:0.10.26
MAINTAINER Joan Llopis <jllopisg@gmail.com>

# Install hipache
RUN npm install hipache@0.2.4 -g

EXPOSE 80

ENTRYPOINT ["hipache"]

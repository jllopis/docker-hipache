# VERSION          v0.2.0
# DOCKER-VERSION   0.11.1
# HIPACHE-VERSION  0.3.1
# AUTHOR:          Joan Llopis <jllopis@acb.es>
# DESCRIPTION:     Image with hipache proxy server
# TO_BUILD:        docker build --rm -t jllopis/hipache:{version} .
# TO_RUN:          docker run -p 443 -p 80 -p 6379 jllopis/hipache:{version}

FROM jllopis/nodejs:0.10.28
MAINTAINER Joan Llopis <jllopisg@gmail.com>

# Configure chris-lea PPA for redis-server
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 136221EE520DDFAF0A905689B9316A7BC7917B12 ;\
	echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu precise main" > /etc/apt/sources.list.d/ppa_chris_lea_redis_server_precise.list ;\
	apt-get -qqy update

# Install redis server
RUN apt-get -qqy install redis-server
ADD redis.conf.orig /etc/redis/redis.conf
RUN chown redis.redis -R /var/lib/redis /var/log/redis

# Install hipache
RUN npm install hipache@0.3.1 -g
ADD ./config.json /usr/local/lib/node_modules/hipache/config/config.json

ENV NODE_ENV production

# Add init script
ADD run.sh /usr/local/bin/run.sh
RUN chown root:root /usr/local/bin/run.sh ;\
    chmod +x /usr/local/bin/run.sh

EXPOSE 80
EXPOSE 443
EXPOSE 6379

ENTRYPOINT ["/usr/local/bin/run.sh"]

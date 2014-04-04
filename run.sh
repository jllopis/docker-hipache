#!/usr/bin/env bash
# VERSION: 0.1.0
# AUTHOR: Joan Llopis <jllopis@acb.es>
REDIS_PORT_6379_TCP_ADDR="localhost"
REDIS_PORT_6379_TCP_PORT=6379
TIMEOUT=${HIPACHE_REDIS_TIMEOUT:=10}

reset="\033[0m"
underline="\033[4m"
bold="\033[1m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"
orange="\033[33m"
purple="\033[31m"
grey="\033[37m"

echo -e "${cyan}${bold}Wait for Redis to start (timeout ${TIMEOUT}s)${reset}"
until $(: </dev/tcp/${REDIS_PORT_6379_TCP_ADDR}/${REDIS_PORT_6379_TCP_PORT} 2>/dev/null); do
	sleep 1
	let TIMEOUT=TIMEOUT-1
	if [ $TIMEOUT -eq 0 ]; then
		echo -e "${red}${bold}Timeout connecting to Redis. Aborting!${reset}"
		echo -e "${yellow}Start the container for Redis Server and try again${reset}"
		exit 1
	fi
done

echo -e "${green}Successfully connected to Redis!${reset}"

echo -3 "${cyan}Starting hipache...${reset}"
/usr/local/bin/hipache -c /usr/local/lib/node_modules/hipache/config/config.json


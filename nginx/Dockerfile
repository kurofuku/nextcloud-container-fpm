FROM		owasp/modsecurity-crs:nginx

RUN			\
			apt -y update && apt -y upgrade && \
			apt -y install apt-utils autoconf automake build-essential git libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libtool libxml2-dev libyajl-dev pkgconf wget zlib1g-dev && \
			git clone --depth 1 -b v3.0.5 https://github.com/SpiderLabs/ModSecurity && \
			cd ModSecurity && git submodule init && git submodule update && \
			./build.sh && \
			./configure && \
			make && \
			make install && \
			# Done
			echo "Build complete." 

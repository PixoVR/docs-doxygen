
#FROM	docs-docker-base
FROM	gcr.io/pixo-bootstrap/docs-docker-base:latest

ARG	CACHEBREAKER=https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h

WORKDIR	/build

COPY	. .

RUN	doxygen -v	# confirm doxygen version from docs-docker-base

ADD	$CACHEBREAKER skipcache

# ensure the doxygen stuff is most up to date
# Force fresh git operations to avoid cached states
RUN	cd /build && \
	git clean -fd && \
	git submodule foreach --recursive 'git clean -fd' && \
	git submodule sync --recursive && \
	git submodule update --init --recursive --force && \
	cd documentation/docs-doxygen && \
	git fetch origin && \
	git reset --hard origin/main

RUN	git fetch --tags

#ADD	$CACHEBREAKER skipcache

RUN	./documentation/build.sh && \
	eval "$(cat ./documentation/env.sh | grep PROJECT_URL)" && \
	mkdir -p /var/www/html && \
	mv ./documentation/html /var/www/html/$PROJECT_URL
	#mkdir -p /var/www/html/$PROJECT_URL && \
	#cp -r ./documentation/html/* /var/www/html/$PROJECT_URL

#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD	["nginx", "-g", "daemon off;"]

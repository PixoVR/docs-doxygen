
FROM	docs-docker-base

WORKDIR	/build

COPY	. .

RUN	doxygen -v	# confirm doxygen version from docs-docker-base

RUN	./documentation/build.sh && \
	cp -r ./documentation/html /var/www/

#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD	["nginx", "-g", "daemon off;"]

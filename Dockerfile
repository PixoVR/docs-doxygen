
FROM	docs-docker-base

WORKDIR	/build

COPY	. .

RUN	doxygen -v	# confirm doxygen version from docs-docker-base

RUN	chmod 755 ./documentation/docs-doxygen/scripts/* && \
	./documentation/build.sh

COPY	/build/documentation/html/ /var/www/html

#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD	["nginx", "-g", "daemon off;"]


FROM	docs-docker-base

WORKDIR	/build

COPY	. .

RUN	doxygen -v	# confirm doxygen version from docs-docker-base

RUN	chmod 755 ./documentation/docs-doxygen/scripts/* && \
	./documentation/build.sh

COPY	documentation/docs-doxygen/nginx.conf /etc/nginx/
RUN	rm /etc/nginx/conf.d/default.conf

COPY	/build/documentation/html/ /var/www/html

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD	["nginx", "-g", "daemon off;"]

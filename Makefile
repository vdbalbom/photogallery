run:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build nginx typeinstant && \
	docker-compose run --service-ports nginx

run-detached:
	docker-compose stop && \
  docker-compose rm && \
  docker-compose build nginx typeinstant && \
  docker-compose run -d --service-ports nginx

inside-container:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build typeinstant && \
	docker-compose run --rm typeinstant bash

test-typeinstant:
	docker-compose stop &&\
	docker-compose rm && \
	docker-compose build test-typeinstant && \
	docker-compose run --rm test-typeinstant

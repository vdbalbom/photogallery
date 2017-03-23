run:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build nginx photoblog && \
	docker-compose run --service-ports nginx

run-detached:
	docker-compose stop && \
  docker-compose rm && \
  docker-compose build nginx photoblog && \
  docker-compose run -d --service-ports nginx

inside-container:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build photoblog && \
	docker-compose run --rm photoblog bash

test-photoblog:
	docker-compose stop &&\
	docker-compose rm && \
	docker-compose build test-photoblog && \
	docker-compose run --rm test-photoblog

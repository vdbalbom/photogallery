run:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build nginx photogallery && \
	docker-compose run --service-ports nginx

run-detached:
	docker-compose stop && \
  docker-compose rm && \
  docker-compose build nginx photogallery && \
  docker-compose run -d --service-ports nginx

inside-container:
	docker-compose build photogallery && \
	docker-compose run --rm photogallery bash

test-photogallery:
	docker-compose stop &&\
	docker-compose rm && \
	docker-compose build test-photogallery && \
	docker-compose run --rm test-photogallery

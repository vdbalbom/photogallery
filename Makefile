run-dev:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build photogallery-dev && \
	docker-compose run --service-ports photogallery-dev

run-prod:
	docker-compose stop && \
	docker-compose rm && \
	docker-compose build nginx photogallery && \
	docker-compose run --service-ports nginx

run-prod-detached:
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

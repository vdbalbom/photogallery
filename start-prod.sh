rm -f /photogallery/tmp/pids/server.pid || true &&
bundle exec rails db:migrate &&
rails assets:precompile &&
bundle exec rails s -p 3000 -b '0.0.0.0'

# Running

* `docker-compose up`
* `docker-compose exec app rails db:setup`
* `docker-compose exec app rails db:migrate`

# Tests

`docker-compose run --rm app bundle exec rspec`
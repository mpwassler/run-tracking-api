# Running

* `mv .env.example .env`
* `docker-compose up -d`
* `docker-compose exec app rails db:setup`
* `docker-compose exec app rails db:migrate`

# Tests

`docker-compose run --rm app bundle exec rspec`

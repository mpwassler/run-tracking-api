WIP. A demo application I plan to write a blog post on. It is an api project for tracking runs. Accompanies a [react native client](https://github.com/mpwassler/rn-run-tracking-app). 

Requires docker


# Running

* `mv .env.example .env`
* `docker-compose up -d`
* `docker-compose exec app rails db:setup`
* `docker-compose exec app rails db:migrate`
* Visit [localhost:3000](http://localhost:3000)

# Tests

`docker-compose run --rm app bundle exec rspec`

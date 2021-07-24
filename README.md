# README

## Environment
Ruby: 3.0.2
Rails:6.1.4
MeCab

## SetUp
```
$ docker compose build
```

```
$ docker compose run web bundle exec rails db:create
```

```
$ docker compose run web bundle exec rails db:migrate
```

```
$ docker compose up
```


## Use Webpacker
```
$ docker compose run web bundle exec rails webpacker:install
```

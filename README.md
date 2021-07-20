# Open Source Friday

Open source is made by people just like you. This Friday, invest a few hours contributing to the software you use and love.

## What this is

This repository is the source code for https://opensourcefriday.com.

Open Source Friday is a movement to encourage people, companies, and maintainers to contribute a few hours to open source software every Friday.

Open Source Software (OSS) is the backbone of most software, tools, apps, electronics and more that we use every day. Not only is Open Source Friday about encouraging people to contribute, but it's about encouraging businesses to give back to the software they use by setting aside time for our colleagues to work on OSS on the clock.

By signing up to the website, you can view and share your and your friends' Friday contributions. You'll also find a number of guides on getting started with open source and being a good maintainer.

### What this isn't

We are not a place where you're going to get free t-shirts or other kinds of gifts for your contributions. This tends to bring out bad behaviour like PRs that change a single line of whitespace, which waste maintainers time and energy, the rewards should be less tangible.

## Translation

See [CONTRIBUTING.md#Translation](CONTRIBUTING.md#Translation).

## Development

Source hosted at [GitHub](https://github.com/github/opensourcefriday).
Report issues/feature requests on [GitHub Issues](https://github.com/github/opensourcefriday/issues).

### Getting Started

Register a [new GitHub OAuth application](https://github.com/settings/applications/new).

* Set the homepage to `http://localhost:3000`.
* Set the authorization callback URL to `http://localhost:3000/users/auth/github/callback`.

Create the config file for the client ID and secret generated for your GitHub OAuth application:

```console
cp config/application.example.yml config/application.yml
```

Update `config/application.yml`, setting the `github_client_id` and `github_client_secret`.

The environment variables are managed using [figaro](https://github.com/laserlemon/figaro).

#### Bootstrapping the Application

If you're on macOS, have Homebrew installed, and you've set the environment variables above to get started run:

```console
./script/bootstrap
./script/setup
./script/server
```

This should get you started with this project on your machine. Otherwise, no worries! You can use the following instructions to install all dependencies and setup a local server.

First, you'll need to install Ruby. We recommend using the excellent [rbenv](https://github.com/rbenv/rbenv),
and [ruby-build](https://github.com/rbenv/ruby-build)

```console
rbenv install
```

Next, you'll need to make sure that you have PostgreSQL installed. On Debian-based Linux distributions you can use apt-get to install Postgres:

```console
sudo apt-get install postgresql postgresql-contrib libpq-dev
```

On Windows, you can use the [Chocolatey package manager](http://chocolatey.org/) to install Postgres:

```console
choco install postgresql
```

Now, let's install the gems from the `Gemfile` ("Gems" are synonymous with libraries in other
languages).

```console
gem install bundler && rbenv rehash
bundle install
```

Once all the gems are installed, we'll need to create the databases and
tables. Rails makes this easy.

```console
./bin/setup
```

Now all we have to do is start up the Rails server and point
our browser to <http://localhost:3000>

```console
./script/server
```

### Note on Patches/Pull Requests

* Fork the project.
* Clone your fork to your machine.
* Create a new branch for your feature/fix.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don't break it in a future version unintentionally.
* Submit a pull request.

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Copyright

Copyright (c) Open Source Friday contributors. See [LICENSE](https://github.com/github/opensourcefriday/blob/master/LICENSE.txt) for details.

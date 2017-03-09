# OSS Friday

Contribute to open source every Friday :beers:

## What is this?

OSS Friday is a movement, inspired by https://24pullrequests.com, to encourage people to contribute to open source every Friday :christmas_tree:

*Alternative name: 52 pull requests* 🤣

Some of the things that worked well for 24 Pull Request that I'd like replicate:

- **opt-in for maintainers** - only suggesting projects that maintainers have suggested means we don't send a swarm of extra maintainer work to someone who doesn't want it or can't handle it.
- **Wisdom of crowds** - if lots of people are doing the same thing at the same time more people will make an effort to join in
- **Gamification** - a little bit of gamification goes a long way, I'm thinking streaks for having done some kind of contribution every Friday throughout the year
- **Automation** - many efforts around cultivating open source contributions that require humans tend to fizzle out as the humans involved can't sustain the level of work required to keep it going, 24 Pull Requests pretty much runs itself now which is why it's been so easy to keep it going for 5 years
- **Emails** - sending out regular reminder emails with suggested contribution content works great to give people a kick to keep them going, optional for people who hate email.
- **Avoid rewards** - Getting free t-shirts or other kinds of gifts tends to bring out bad behaviour like prs that change a single line of whitespace, which waste maintainers time and energy, the rewards should be a bit less tangible

Things I'd like to try:

- **Focusing on issues rather than projects** - trying to find a project to contribute to and then find something to do on that project is tricky, instead let's get maintainers to label issues that they want to promote to new contributors with `ossfriday` along with related labels like `Your First PR`, `first-timers-only` and `help wanted`

- **not tied to pull requests** - there are lots of ways someone can contribute to an open source project that doesn't require opening a PR on GitHub, we should encourage things like documentation, issue triage, stackoverflow answering, support forum helping, event organising, blogging as well as code contributions

- **Three target audiences** - Individual contributors, maintainers and companies (h/t @MikeMcQuaid) are the three types of audience we should be catering to, with documentation for each one on how to get involved. I can see the homepage being split in half for contributors and maintainers and then companies slightly further down.

I'm planning on getting something basic together (in ruby of course) before 6th January, the first Friday of 2017 and we can iterate from there 🚀

Would love to hear your ideas, thoughts, feedback, contributions, gifs and emoji reactions, Happy Friday 🍻

Check out the "Hello world" issue to see see the ongoing discussion: https://github.com/ossfriday/ossfriday/issues/2

## Development

Source hosted at [GitHub](https://github.com/ossfriday/ossfriday).
Report issues/feature requests on [GitHub Issues](https://github.com/ossfriday/ossfriday/issues).

### Getting Started

New to Ruby? No worries! You can follow these instructions to install a local server.

First things first, you'll need to install Ruby 2.4.0. I recommend using the excellent [rbenv](https://github.com/rbenv/rbenv),
and [ruby-build](https://github.com/rbenv/ruby-build)

```bash
rbenv install
```

Next, you'll need to make sure that you have PostgreSQL installed. This can be
done easily on macOS using [Homebrew](http://brew.sh) or by using [http://postgresapp.com](http://postgresapp.com).

```bash
brew install postgresql && brew services restart postgresql
```

On Debian-based Linux distributions you can use apt-get to install Postgres:

```bash
sudo apt-get install postgresql postgresql-contrib libpq-dev
```

On Windows, you can use the [Chocolatey package manager](http://chocolatey.org/) to install Postgres:

```bash
choco install postgresql
```

Now, let's install the gems from the `Gemfile` ("Gems" are synonymous with libraries in other
languages).

```bash
gem install bundler && rbenv rehash
bundle install
```

Once all the gems are installed, we'll need to create the databases and
tables. Rails makes this easy through the use of "Rake" tasks.

```bash
bundle exec rake db:create:all
bundle exec rake db:migrate
```

And we can also add some sample data with the **seed** task.

```bash
bundle exec rake db:seed
```

If you are working on anything related to the email-generation code, you can use [MailCatcher](https://github.com/sj26/mailcatcher).
Since we use Bundler, please read the [following](https://github.com/sj26/mailcatcher#bundler) before using MailCatcher.

Almost there! Now all we have to do is start up the Rails server and point
our browser to <http://localhost:3000>

```bash
bundle exec rails s
```

### Environment variables

```bash
bundle exec figaro install
```

You'll need to set at least `github_client_id` and `github_client_secret` environment variables. The values can be obtained by [registering a new GitHub OAuth application](https://github.com/settings/applications/new) with the Authorization callback URL pointing to your application with `/users/auth/github/callback` appended.

Or for more information about using figaro, see https://github.com/laserlemon/figaro

### Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so we don't break it in a future version unintentionally.
 * Send a pull request. Bonus points for topic branches.

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Copyright

Copyright (c) 2016 Andrew Nesbitt. See [LICENSE](https://github.com/ossfriday/ossfriday/blob/master/LICENSE.txt) for details.

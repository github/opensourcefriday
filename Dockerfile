# Start with a base Ruby
FROM ruby:2.3

WORKDIR /usr/src/rails-app

# Install RubyGems dependencies
COPY Gemfile* ./
RUN bundle

# The server port
EXPOSE 3000

# Grab the code
COPY . .

# Create non-root user to run as
RUN useradd --create-home --user-group github
USER github

# Run an HTTP server by default
CMD ["rails", "server", "-b", "0.0.0.0"]

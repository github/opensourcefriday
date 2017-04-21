Octokit.middleware = Faraday::RackBuilder.new do |builder|
  builder.use :http_cache, serializer: Marshal, store: Rails.cache,
                           shared_cache: false, logger: Rails.logger,
                           instrumenter: ActiveSupport::Notifications
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end

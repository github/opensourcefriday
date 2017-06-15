class MailChimp
  def self.subscribe(email)
    new.subscribe(email)
  end

  attr_reader :username, :api_key, :list_id
  def initialize
    @username = ENV["mailchimp_user"]
    @api_key = ENV["mailchimp_api_key"]
    @list_id = ENV["mailchimp_list_id"]
  end

  def subscribe(email)
    return false if email.blank?

    response = connection.post do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Accept"] = "application/json"
      req.headers["User-Agent"] = user_agent

      req.url subscribe_path
      req.body = {
        email_address: email,
        status: "subscribed",
      }.to_json
    end
    JSON.parse(response.body)["status"] == "subscribed"
  end

  private

  def connection
    conn = Faraday.new(url: api_url) do |c|
      c.use Faraday::Adapter::NetHttp
    end
    conn.basic_auth(username, api_key)
    conn
  end

  def api_url
    format("https://%s.api.mailchimp.com", datacenter)
  end

  def api_version
    "3.0"
  end

  def subscribe_path
    raise "mailchimp_list_id missing!" unless list_id
    format("/%s/lists/%s/members", api_version, list_id)
  end

  def datacenter
    raise "mailchimp_api_key missing!" unless api_key
    api_key.to_s.split("-").last
  end

  def user_agent
    "github.com:ossfriday/ossfriday"
  end
end

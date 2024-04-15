class OmdbClient
  URL = 'http://www.omdbapi.com'

  def initialize
    @api_key = Rails.application.credentials.omdb[:api_key]
  end

  def search(string)
    begin
      response = Faraday.get(URL, {apikey: @api_key, s: string})
      parse_body(response)
    rescue Faraday::ConnectionFailed => e
      puts "error: #{e.message}"
    rescue Faraday::TimeoutError => e
      puts "error: #{e.message}"
    rescue JSON::ParserError => e
      puts "error: #{e.message}"
    end
  end

  def search_by_title(string)
    parse_body(
      Faraday.get(URL, {apikey: @api_key, t: string})
    )
  end

  def find_by_id(id)
    parse_body(
      Faraday.get(URL, {apikey: @api_key, i: id})
    )
  end

  private
  def parse_body(response)
    JSON.parse(response.body)
  end
end
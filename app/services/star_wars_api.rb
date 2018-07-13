class StarWarsApi
  include HTTParty
  base_uri 'https://swapi.co/api/'

  def initialize(path)
    @path    = path
    @options = { headers: { "Content-Type" => "application/json", "Authorization" => '' } }
  end

  def call
    message_handler(self.class.get(@path, @options))
  end

  private
  def message_handler(res)
    case res.code
    when 200
      res
    when 404
      { error: "This is not the endpoint you're looking for", status: :unprocessable_entity }
    when 500..600
      { error: 'Something borked', status: :unprocessable_entity }
    end
  end

end
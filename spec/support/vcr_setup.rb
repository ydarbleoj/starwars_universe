VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.allow_http_connections_when_no_cassette = false
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
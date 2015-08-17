require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users',
).to_s

# puts RestClient.post(url, body: "blabla", test: "test paramater")
puts RestClient.get(url)

require 'addressable/uri'
require 'rest-client'

def get_users
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users',
  ).to_s

  puts RestClient.get(url)
end

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users'
  ).to_s

  puts RestClient.post(
    url,
    { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
  )
end

def create_invalid_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users'
  ).to_s

  begin
    puts RestClient.post(
      url,
      { user: { name: "Gizmo" } }
    )
  rescue RestClient::Exception
    puts "invalid user info"
  end
end

def show_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users' + "/#{id}"
  ).to_s

  puts RestClient.get(url)
end

def update_user(id, name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}"
  ).to_s

  puts RestClient.patch(
    url,
    {user: {name: name, email: email}}
  )
end

def destroy_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users' + "/#{id}"
  ).to_s

  puts RestClient.delete(url)
end

# create_user
# create_invalid_user
# show_user(1)
#update_user(1, "Arthur", "arthur111@hotmail.com")
#destroy_user(1)
get_users

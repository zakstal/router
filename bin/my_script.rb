require 'addressable/uri'
require 'rest-client'

# bin/my_script.rb

# def create_user
#   url = Addressable::URI.new(
#     scheme: 'http',
#     host: 'localhost',
#     port: 3000,
#     path: '/users.json'
#   ).to_s
#
#   puts RestClient.post(
#     url,
#     { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
#   )
# end
#
def show_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/2'
  ).to_s

  puts RestClient.get(
    url
  )
end
#
class Test
  def method_missing(method_name, *args)
    info_hash = {
      {verb: 'get', path: 'users'}  => 'index',
      {verb: 'post', path: 'users'} => 'create',
      {verb: 'get', path: 'users/new'} => 'new',
      {verb: 'get', path: 'users/:id/edit'} => 'edit',
      {verb: 'get', path: 'users/:id'} => 'show',
      {verb: 'patch', path: 'users/:id'} => 'update',
      {verb: 'put', path: 'users/:id'} => 'update',
      {verb: 'delete', path: 'users/:id'} => 'destroy'
    }.invert

    method_called = method_name.to_s.split('_').first
    verbs = info_hash[method_called]

    url = Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: verbs[:path]
    ).to_s

    puts RestClient.send(
      verbs[:verb],
      url,
      { user: args }
    )#optional user args
  end
end

Test.new.create_user({name: "Sam", email: "sam@sam.com"})
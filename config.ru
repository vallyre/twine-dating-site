# Dir["lib/resources/*.rb"].each { |file| require file }
require_relative 'lib/resources/likes_api'
require_relative 'lib/resources/users_api'

run Sinatra::Application

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}

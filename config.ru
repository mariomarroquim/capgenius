require 'rack'

require_relative 'service'

app = proc do |env|
  request = Rack::Request.new(env)

  service = Service.instance
  output = ''

  begin
    output = service.read_captcha(request.params["captcha"][:tempfile].path)
  rescue StandardError => e
    puts e.message, e.backtrace
    output = "Error: #{e.message}"
  end

  [200, {}, [output]]
end

run app

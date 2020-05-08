class App

  def call(env)
    request = Rack::Request.new(env)
    if path_valid?(request)
      path_valid(request)
    else
      path_invalid
    end
  end

  private

  def path_valid?(request)
    request.path_info == '/time'
  end

  def path_invalid
    response(404, headers, "Not Found\n")
  end

  def path_valid(request)
    date_format = DateFormat.new(request.params['format'])
    date_format.call

    if date_format.valid?
      response(200, headers, date_format.valid)
    else
      response(400, headers, date_format.invalid)
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, header, body)
    response = Rack::Response.new
    response.status = status
    response.headers.merge(header)
    response.body = [body]

    response.finish
  end
end

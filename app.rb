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
    response(404, "Not Found\n")
  end

  def path_valid(request)
    date_format = DateFormat.new(request.params['format'])
    date_format.call

    if date_format.valid?
      response(200, date_format.valid)
    else
      response(400, date_format.invalid)
    end
  end

  def response(status, body)
    response = Rack::Response.new
    response.status = status
    response.headers['Content-Type'] = 'text/plain'
    response.body = [body]

    response.finish
  end
end

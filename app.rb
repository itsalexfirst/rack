class App

  def call(env)
    @req = Rack::Request.new(env)
    if path_valid?(env)
      [
        404,
        { 'Content-Type' => 'text/plain' },
        [@req.params['format']]
      ]

      date_format = DateFormat.new(@req.params['format'])

      if date_format.valid?
        status = 200
        body = date_format.valid
      else
        status = 400
        body = date_format.invalid
      end

      [status, headers, [body]]
    else
      path_invalid
    end
  end

  private

  def path_valid?(env)
    @req.path_info == '/time'
  end

  def path_invalid
    [
      404,
      { 'Content-Type' => 'text/plain' },
      ["Not Found\n"]
    ]

  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end

class DateFormat

  ALLOW_FORMATS = {
    "year" => "%Y",
    "month" => "%m",
    "day" => "%d",
    "hour" => "%H",
    "minute" => "%M",
    "second" => "%S"
  }.freeze

  def initialize(format)
    @format = format.split(',')
    @unknown_format = @format.reject { |format| ALLOW_FORMATS.key?(format) }
  end

  def valid?
    @unknown_format.empty? ? true : false
  end

  def valid
    time_params = @format.map{ |val| ALLOW_FORMATS[val] }
    return Time.now.strftime(time_params.join("-"))
  end

  def invalid
    return "Unknow time format #{@unknown_format}"
  end

end

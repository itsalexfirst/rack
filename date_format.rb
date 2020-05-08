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
    @format = format
    @unknown_format = []
    @time_params = []
  end

  def call
    @format = @format.split(',')

    @format.each do |param|
      if ALLOW_FORMATS.key?(param)
        @time_params << ALLOW_FORMATS[param]
      else
        @unknown_format << param
      end
    end
  end

  def valid?
    @unknown_format.empty?
  end

  def valid
    return Time.now.strftime(@time_params.join("-"))
  end

  def invalid
    return "Unknow time format #{@unknown_format}"
  end

end

class ToastComponent < ApplicationComponent
  def initialize(type:, msg:)
    @type = type
    @msg  = msg
  end

  def toast_icon
    case @type
    when "success"
      "check-circle-solid"
    when "alert"
      "x-circle-solid"
    else
      raise "Unhandled type: #{@type}"
    end
  end
end

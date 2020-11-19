class Cards::DumbComponent < ApplicationComponent
  def initialize(url:, title:, description:, type:)
    @url          = url
    @title        = title
    @description  = description
    @type         = type
  end

  def icon
    case @type
    when "changelog"
      "clipboard-list"
    when "team"
      "users"
    when "setting"
      "cog"
    when "tag"
      "tag"
    else
      raise "Unhandled type: #{@type}"
    end
  end

  def icon_container_color
    case @type
    when "changelog"
      "#E74694"
    when "team"
      "#31C48D"
    when "setting"
      "#7E3AF2"
    when "tag"
      "#16BDCA"
    else
      raise "Unhandled type: #{@type}"
    end
  end
end

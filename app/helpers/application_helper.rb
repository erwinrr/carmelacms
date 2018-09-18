module ApplicationHelper
  def icon_link(icon, title)
    return "<i class=\"icon mdi #{icon}\"></i><span>#{title}</span>".html_safe
  end
end

module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def facebook?
    session["devise.facebook_data"]
  end

  def user_image(user)
    "<img src=\"#{ user.image }\">".html_safe
  end
end

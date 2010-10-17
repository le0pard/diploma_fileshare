module ApplicationHelper
  
  def menu_link(title, link, with_action = false)
    route_hash = Rails.application.routes.recognize_path(link) rescue {:controller => nil, :action => nil}
    unless route_hash[:controller].nil?
      boolean_menu = false
      if with_action
        boolean_menu = (controller.controller_path == route_hash[:controller] && controller.action_name == route_hash[:action])
      else
        boolean_menu = (controller.controller_path == route_hash[:controller])
      end
      
      css_class = ""
      css_class = "class='active'" if boolean_menu
      link_to raw("<small #{css_class}>#{title}</small>"), link
    end
  end
  
end

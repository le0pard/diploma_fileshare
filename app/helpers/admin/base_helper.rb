module Admin::BaseHelper
  
  def admin_menu_link(title, link, with_action = false)
    route_hash = Rails.application.routes.recognize_path(link) rescue {:controller => nil, :action => nil}
    unless route_hash[:controller].nil?
      boolean_menu = false
      if with_action
        boolean_menu = (controller.controller_path == route_hash[:controller] && controller.action_name == route_hash[:action])
      else
        boolean_menu = (controller.controller_path == route_hash[:controller])
      end
      link_to_unless(boolean_menu, title, link) {"<span>#{title}</span>"}
    end
  end
  
end

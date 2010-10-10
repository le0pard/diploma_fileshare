RailsShop::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  namespace :admin do
    resources :catalog do
      collection do 
        get 'tree'
        get 'move'
      end
    end  
  end

  namespace :user, :as => '', :path => "/" do
    match "signin" => "user_sessions#new", :via => :get
    match "signin" => "user_sessions#create", :via => :post 
    match "logout" => "user_sessions#destroy", :via => [:get, :post]
    
    match "signup" => "users#new", :via => :get
    match "signup" => "users#create", :via => :post
    resource :account, :controller => "users", :only => [:show]
    
    match "password_resets" => "password_resets#new", :via => :get
    match "password_resets" => "password_resets#create", :via => :post
    match "edit_password_resets/:perishable_token" => "password_resets#edit", :as => "edit_password_resets", :via => :get
    match "edit_password_resets/:perishable_token" => "password_resets#update", :as => "edit_password_resets", :via => :put
  end
  
  root :to => "admin/catalog#index"
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

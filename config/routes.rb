Centraldecomando::Application.routes.draw do
  resources :stories

  resources :sprints

  resources :tickets

  resources :clients

  resources :projects
  
  resources :filters
  
  resources :comments

  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'home' => 'home#index', :as => :home
  #match 'cc_users' => 'cc_users#index', :as => :cc_users
  resource :session, :controller => 'sessions'
  resources :cc_users
  match 'user' => 'cc_users#edit'
  match '/tickets/change_status/:id' => 'tickets#change_status'
  match '/sprints/planning/:id' => 'sprints#planning', :as => :planning
  match 'sprints/get_stories/:id' => 'sprints#get_stories', :via => :get
  match '/stories_search' => 'stories#search', :via => :get
  match '/sprints_add_story' => 'sprints#add_story', :via => :post
  match '/execute_filter/:id' => 'filters#execute', :via => :get, :as => :execute_filter
  
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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

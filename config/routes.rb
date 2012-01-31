Centraldecomando::Application.routes.draw do
  
  resources :cc_users do       
    member do
      post 'alter_password'
    end
  end
  
  resources :charts
  resources :clients
  resources :comments
  resources :filters
  resources :layouts do
    resources :layout_fields do 
      member do
        get 'change_order'
      end
    end
  end
  resources :priorities
  resources :projects do 
    resources :project_members
  end
  resources :specifications do                
    resources :specification_fields 
  end
  resources :sprints do
    collection do
        get 'combo_sprints'
      end        
    member do       
      delete 'close'  
    end
    resources :tickets_sprints 
  end
  
  resources :stories
  resources :tickets do
    member do
      get 'change_user_owner'
    end
  end
  resources :ticket_hours
  resources :user_profiles  
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'home' => 'home#index', :as => :home       
  match 'home_po' => 'home#index_po', :as => :home_po
  #match 'cc_users' => 'cc_users#index', :as => :cc_users
  resource :session, :controller => 'sessions'
  
  match 'user' => 'cc_users#edit'
  match '/tickets/change_status/:id' => 'tickets#change_status'
  #match '/sprints/planning/:id' => 'sprints#planning', :as => :planning
  match 'sprints/get_stories/:id' => 'sprints#get_stories', :via => :get
  match '/stories_search' => 'stories#search', :via => :get
  match '/sprints_add_story' => 'sprints#add_story', :via => :post
  match '/execute_filter/:id' => 'filters#execute', :via => :get, :as => :execute_filter 
  match '/save_ticket_sprint/:sprint_id' => 'tickets_sprints#save', :via => :post, :as => :save_ticket_sprint
  
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

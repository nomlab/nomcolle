Nomcolle::Application.routes.draw do
  resources :rooms

  resources :bowling_teams

  resources :bowling_matches
  get "bowling_matches/:id/manage_bowling_participants", to: "bowling_matches#manage_bowling_participants"
  post "bowling_matches/:id/register_participants", to: "bowling_matches#register_participants"
  get "bowling_matches/:id/record_bowling_match_scores", to: "bowling_matches#record_bowling_match_scores"
  post "bowling_matches/:id/update_bowling_match_scores", to: "bowling_matches#update_bowling_match_scores"

  delete "bowling_matches/:id/destroy_bowling_scores", to: "bowling_matches#destroy_bowling_scores"

  get "individual/index"

  root :to => "welcome#index"

  get "welcome/:action" => "welcome#:action"
  post "welcome/:action" => "welcome#:action"

  resources :images

  controller "subscription_requests", :path=>"subscription_requests" do
    get "new_from_book_list"
  end

  resources :subscription_requests

  controller "reviews", :path=>"reviews" do
    get "new_from_book_list"
  end

  resources :reviews

  resources :histories

  resources :users

  controller "books", :path=>"books"  do
    get "new_from_isbn"
    get "new_from_plural_isbn"
    get "list_subscription_requests"
    post "create_from_isbn"
    post "create_from_plural_isbn"
    post "rent"
    post "return"
  end

  resources :books

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

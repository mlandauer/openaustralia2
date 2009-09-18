ActionController::Routing::Routes.draw do |map|
  map.representatives 'mps', :controller => 'member', :action => 'representatives', :trailing_slash => true
  # TODO: Hardcoding house numbers below. Very nasty.
  map.representative 'mp', :controller => 'member', :action => 'show', :house => 1, :trailing_slash => true
  map.senators 'senators', :controller => 'member', :action => 'senators', :trailing_slash => true
  map.connect 'mp/:name/:constituency', :controller => 'member', :action => 'show', :house => 1
  map.connect 'senator/:name/:constituency', :controller => 'member', :action => 'show', :house => 2
  map.connect 'debates', :controller => 'debate', :action => 'debate'
  map.speech 'debate', :controller => 'debate', :action => 'speech', :trailing_slash => true
  map.connect 'hansard', :controller => 'debate', :action => 'hansard'
  map.posts 'news', :controller => 'news', :action => 'index', :trailing_slash => true
  map.post 'news/archives/:year/:month/:day/:title', :controller => 'news', :action => 'show'
  map.connect 'news/archives/:year/:month', :controller => 'news', :action => 'index'
  map.recent_comments 'comments/recent', :controller => 'comments', :action => 'recent', :trailing_slash => true
  map.user 'user', :controller => 'user', :action => 'show', :trailing_slash => true
  map.login 'user/login', :controller => 'user', :action => 'login', :trailing_slash => true
  map.report 'report', :controller => 'comments', :action => 'report', :trailing_slash => true

  # For rendering the static content pages
  map.help 'help', :controller => 'static', :action => 'help', :trailing_slash => true
  map.about 'about', :controller => 'static', :action => 'about', :trailing_slash => true
  map.contact 'contact', :controller => 'static', :action => 'contact', :trailing_slash => true
  map.link_to_us 'help/linktous', :controller => 'static', :action => 'link_to_us', :trailing_slash => true
  map.house_rules 'houserules', :controller => 'static', :action => 'house_rules', :trailing_slash => true
  
  map.root :controller => "home"
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end

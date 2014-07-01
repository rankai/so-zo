SoZo::Application.routes.draw do

  get "static_pages/company"
  get "static_pages/help"
  get "static_pages/treaty"
  get "static_pages/license"
  mount Rich::Engine => '/rich', :as => 'rich'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  #devise_for :users
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get 'home/index'

  resources :statistics
  resources :watches
  resources :collections
  resources :bases
  resources :line_items
  resources :carts
  get '/search' => 'search#search'

  #------------------------------- publishes ------------------------
  
  resources :checkouts, only:[:wepay, :result] do
    collection do
      get 'checkout'
      get 'wepay'
      get 'result'
    end
  end

  resources :users do
      get 'publishes', :to => 'publishes#works'
      get 'products',  :to => "products#products"
      post 'watch'
      resources :watches do
      end
      resources :products do
        collection do
          put 'setpriceonce'
        end
      end
      resources :collections do
      end
      resources :publishes do
        collection do 
          delete "reset"
          put "commit"
        end
        #get 'works', :on => :collection
      end
      resources :orders do
        collection do
          get 'confirm'
        end
        resources :items
      end
  end

  #get "users/:user_id/publishes", :to => "publishes#works"
  #get "users/:user_id/public",    :to => "users#public"

  resources :publishes, only:[:index, :show] do 
    collection do
      get 'hot'
    end
  end

  #------------------------------- publishes ------------------------


  #resources :publishes

  #resources :users do
  #  resources :publishes
  #end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'home#index'
   root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
     resources :products do
        collection do
          get 'preview'
          get 'top'
        end
     end
     
     resources :authors
     resources :promtions
     resources :tags

  #  custom action route


  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # rescue errors
  #get '*path' => proc { |env| Rails.env.development? ? (raise ActionController::RoutingError, %{No route matches "#{env["PATH_INFO"]}"}) : ApplicationController.action(:render_not_found).call(env) }
end

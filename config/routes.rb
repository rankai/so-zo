SoZo::Application.routes.draw do

  resources :bases

  resources :line_items

  resources :carts

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users

  get 'home/index'


  #------------------------------- publishes ------------------------
  
  resources :checkouts, only:[:wepay, :result] do
    collection do
      get 'wepay'
      get 'result'
    end
  end

  resources :users do
      resources :products do
      end
      resources :publishes do
        #get 'works', :on => :collection
      end
      resources :orders do
        collection do
          get 'confirm'
        end
        resources :items
      end
  end

  get "users/:user_id/publishes", :to => "publishes#works"

  resources :publishes, only:[:index, :show] do 
    collection do
      get 'top'
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

  get '*path' => proc { |env| Rails.env.development? ? (raise ActionController::RoutingError, %{No route matches "#{env["PATH_INFO"]}"}) : ApplicationController.action(:render_not_found).call(env) }
end

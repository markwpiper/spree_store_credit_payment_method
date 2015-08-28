Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :users, only: [] do
      resources :store_credits

      collection do
        resources :virtual_gift_cards, controller: 'gift_cards'
      end
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :store_credit_events, only: [] do
      collection do
        get :mine
      end
    end

    resources :gift_cards, only: [] do
      collection do
        post :redeem
      end
    end
  end
end

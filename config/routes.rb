Rails.application.routes.draw do

  root  'public/homes#top'


  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

  namespace :admin do
     resources :items, only: [:new, :create, :index, :show, :edit, :update]
     resources :makers, only: [:new, :create, :index, :show, :edit, :update]
     resources :genres, only: [:new, :create, :index, :edit, :update]
     resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :public do
     resources :items, only: [:index, :show] do
       resource :favorites, only: [:create, :destroy]
     end   
     resources :makers, only: [:index, :show]
     resources :contacts, only: [:new, :create] do
       collection do
         post 'confirm', to: 'contacts#confirm', as: 'confirm'
         post 'back', to: 'contacts#back', as: 'back'
       end
       get 'done', to: 'contacts#done', as: 'done'
     end
     resources :customers, only: [:show, :edit, :update] do
       member do
         get :unsubscribe
         patch :withdraw
         get :favorites
       end
       collection do
         get :favorites
       end
     end
     get 'homes/about' => 'homes#about'
     post 'contacts/confirm' => 'contacts#confirm', as: 'confirm'
     post 'contacts/back' => 'contacts#back', as: 'back'
     get  'done' => 'contacts#done', as: 'done'
  end

end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


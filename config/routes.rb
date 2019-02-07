Rails.application.routes.draw do

  namespace :admin do
    resources :invoice_types
  end
  #concern :active_scaffold_association, ActiveScaffold::Routing::Association.new
  #concern :active_scaffold, ActiveScaffold::Routing::Basic.new(association: true)
  get 'register/new'

  namespace :admin do
    
    resources :people do
      get :search_person           
      get :get_cep
      get "search_fingerprint", to: "people#search_fingerprint",  on: :collection
      get "birthdays_month",    to: "people#birthdays_month",     on: :collection
      get "birthday",           to: "people#birthday",            on: :collection
      get "exportar_pdf",       to: "people#exportar_pdf",        on: :collection
    end

    get '/users' => 'users#index'

    resources :categories
    
    resources :checkins

    resources :emails do
      get "/send_mail", to: "emails#send_mail"
    end
    resources :tuitions

    resources :invoices    
    resources :payments do
      get 'get_debits'
    end

    resources :companies do
      get 'get_cep'
      get 'load_cities'
    end

    get 'webcam/index'
    get 'biometria/applet_nitgen'
    get 'welcome/index'
  end

  get '/admin' => 'admin/welcome#index'
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'admin/welcome#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
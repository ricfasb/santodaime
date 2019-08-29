Rails.application.routes.draw do  
      
  #concern :active_scaffold_association, ActiveScaffold::Routing::Association.new
  #concern :active_scaffold, ActiveScaffold::Routing::Basic.new(association: true)
  get 'register/new'

  namespace :admin do
    
    resources :people do
      get :search_person           
      get :get_cep
      get 'show_image',         :on => :collection
      get "search_fingerprint", to: "people#search_fingerprint",  on: :collection
      get "birthdays_month",    to: "people#birthdays_month",     on: :collection
      get "birthday",           to: "people#birthday",            on: :collection
      get "without_fingerprint",to: "people#without_fingerprint", on: :collection
    end

    get '/users' => 'users#index'

    resources :categories do
      delete "destroy_category_tuition"      
    end         

    resources :checkins do
      get "checkins_pdf",         to: "checkins#checkins_pdf",          on: :collection
      get "without_checkins_pdf", to: "checkins#without_checkins_pdf",  on: :collection
    end

    resources :products
    resources :expenses
    resources :leans
    
    resources :profile_permissions do
      get 'get_permissions'
    end

    resources :profiles

    resources :emails do
      get "/send_mail", to: "emails#send_mail"
    end

    resources :tuitions do 
      get "get_tuition"          
    end

    patch "/tuitions_people" => "tuitions_people#update"

    resources :invoice_types
    resources :invoices    
    resources :payments do
      get 'get_debits'
      get 'get_all_debits'
    end

    get 'cash/index'
    
    get "/users" => 'users#index'    
    post "/users" => "users#create_session"
    patch "/users" => "users#update"

    resources :companies do      
      get "get_cep", to: "companies#get_cep",  on: :collection
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
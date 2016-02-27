Rails.application.routes.draw do

  resources :messages
  resources :students
  resources :instructors do
  	collection { 
  		get :show_pending_students_requests
  		get :show_enrolled_students_requests
  	  	post :enroll_student
  	  	post :unenroll_student
  	  	get :view_my_students
  	  	get :view_my_courses
  	  	post :change_grades
  	  	post :add_material
  	  	post :view_material
  	  	post :request_inactive
  	}
  end
  resources :admins do
  	collection {
  		get :view_instructor_history
  		get :view_student_history
  		get :view_inactive_requests
  		post :make_inactive
  		post :make_active
  	}
  end
  resources :course_students
  resources :materials
  resources :course_instructors do
  collection { post :add_material }
  end
  resources :courses
  resources :users
  
  resources :admin
  
  root :to => 'sessions#new'
  
  get 'sessions/new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  match '/search_courses' => 'courses#search', via: :get

  match '/display_enroll_request' => 'courses#displayenrollrequest', via: :get, :as => :course_enroll_request

  get '/courses/:id' => 'courses#show', :as => :course_show

  match '/drop_course' => 'courses#droprequest', via: :get, :as => :drop_course_request

  #match '/courses/:id'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
end

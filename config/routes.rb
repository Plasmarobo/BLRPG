Rails.application.routes.draw do
  get 'proficiencies/new'

  get 'proficiencies/create'

  get 'proficiencies/index'

  get 'proficiencies/show'

  get 'proficiencies/destroy'

  get 'proficiencies/edit'

  get 'proficiencies/update'

  get 'skills/new'

  get 'skills/create'

  get 'skills/index'

  get 'skills/show'

  get 'skills/destroy'

  get 'skills/edit'

  get 'skills/update'

  get 'attacks/index'

  get 'attacks/new' => 'attacks#new', as: :new_attack

  get 'attacks/new'

  get 'attacks/create'

  get 'attacks/show'

  get 'attacks/edit'

  get 'attacks/update'

  get 'attacks/destroy'

  get 'proficiency_templates/list' => 'proficiency_templates#list', as: :proficiency_select
  resources :proficiency_templates

  get 'skill_templates/list' => 'skill_templates#list', as: :skill_select
  resources :skill_templates

  get 'hunters/new'
  post 'hunters/new'

  get 'hunters/view'

  get 'hunters/edit'

  get 'hunters/delete'
  post 'hunters/delete'

  get 'hunters/update'
  post 'hunters/update'

  get 'hunters/list'

  get 'hunters/:id/skills' => 'hunters#skills'

  get 'hunters/:id/potentials' => 'hunter#potentialskills'

  resources :hunters

  get 'home/dashboard'

  get 'home/about'

  get 'home/pals'

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
  
  root 'home#dashboard'
  devise_for :users
end

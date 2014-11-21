Rails.application.routes.draw do
  get 'minions/new'
  post 'minions/new'

  get 'minions/create'
  post 'minions/create'

  get 'minions/show'
  post 'minions/show'
  
  post 'minions/batch'

  get 'minions/edit'

  get 'minions/index'

  get 'minions/destroy'
  post 'minions/destroy'

  get 'import/google_sheet'

  get 'import/json'

  get 'import/csv'

  get 'import/xlsx'

  get 'attribute_instances/create'
  get 'attribute_instances/update'

  get 'attribute_instances/update'
  post 'attribute_instances/update'

  post 'attribute_instances/batch'

  get 'proficiencies/new'

  get 'proficiencies/create'
  post 'proficiencies/create'

  post 'proficiencies/batch'

  get 'proficiencies/index'

  get 'proficiencies/show'

  get 'proficiencies/destroy'
  post 'proficiencies/destroy'

  get 'proficiencies/edit'

  get 'proficiencies/update'

  get 'skills/new'

  get 'skills/create'
  post 'skills/create'

  post 'skills/batch'

  get 'skills/index'

  get 'skills/show'

  get 'skills/destroy'
  post 'skills/destroy'

  get 'skills/edit'

  get 'skills/update'

  get 'attacks/index'

  get 'attacks/new' => 'attacks#new', as: :new_attack

  get 'attacks/new'
  post 'attacks/new'

  get 'attacks/create'
  post 'attacks/create'

  post 'attacks/batch'

  get 'attacks/show'

  get 'attacks/edit'

  get 'attacks/update'

  get 'attacks/destroy'
  post 'attacks/destroy'

  get 'proficiency_templates/list' => 'proficiency_templates#list', as: :proficiency_select
  resources :proficiency_templates

  get 'skill_templates/list' => 'skill_templates#list', as: :skill_select
  resources :skill_templates

  get 'hunters/new'
  post 'hunters/new'

  get 'hunters/create'
  post 'hunters/create'

  get 'hunters/view'

  get 'hunters/edit'

  get 'hunters/delete'
  post 'hunters/delete'

  get 'hunters/update'
  post 'hunters/update'
  post 'hunters/:id/update' => 'hunters#update'
  get 'hunters/:id/update' => 'hunters#update'

  get 'hunters/list'
 

  get 'hunters/:id/skills' => 'hunters#skills'

  get 'hunters/:id/potentials' => 'hunter#potentialskills'

  get 'hunters/:id/share' => 'hunters#share'
  
  get 'hunters/:id' => 'hunters#show'

  get 'hunters/index' => 'hunters#list'
  get 'hunters/' => 'hunters#list'
  get 'hunters' => 'hunters#list'

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

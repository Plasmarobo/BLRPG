Rails.application.routes.draw do
  
  #Standard routes
  ['items', 'armor', 'gear','races', 'consumables', 'minions', 'modifiers', 'proficiencies', 'skills', 'shields', 'stacks', 'weapons'].each do |target|
    get "/#{target}/new"
    get "/#{target}/create"
    get "/#{target}/edit"
    get "/#{target}/index"
    get "/#{target}/delete"
    get "/#{target}/:id/card" => "#{target}#card"
    
    post "/#{target}/new"
    post "/#{target}/create"
    post "/#{target}/edit"
    post "/#{target}/index"
    post "/#{target}/update" => "#{target}#update"
    post "/#{target}/delete"
    post "/#{target}/:id/card" => "#{target}#card"
  end
  
  #Cards
  ['armor', 'gear','races', 'consumables', 'minions', 'proficiencies', 'skills', 'shields', 'stacks', 'weapons'].each do |target|
    get "/#{target}/card"
    post "/#{target}/card"
  end
  #Lists

  get 'races/list'
  post 'races/list'

  get 'skills/edit_list'
  post 'skills/edit_list'
  
  get 'proficiencies/edit_list'
  post 'proficiencies/edit_list'
  
  get 'items/list' => 'items#list'
  post 'items/list' => 'items#list'

  get 'hunters/new'
  post 'hunters/new'

  get 'hunters/create'
  post 'hunters/create'

  get 'hunters/delete'
  post 'hunters/delete'

  get 'hunters/update'
  post 'hunters/update'

  post 'hunters/:id/update' => 'hunters#update'
  get 'hunters/:id/update' => 'hunters#update'
  
  targets = ["skill", "proficiency", "weapon", "armor", "consumable", "shield", "gear" ]
  targets.each do |target|
    get "hunters/:id/drop/#{target}" => "hunters#drop#{target}"
    post "hunters/:id/drop/#{target}" => "hunters#drop#{target}"
    
    get "hunters/:id/add/#{target}" => "hunters#add#{target}"
    post "hunters/:id/add/#{target}" => "hunters#add#{target}"
    
    get "hunters/:id/#{target.pluralize}" => "hunters#list#{target.pluralize}"
    post "hunters/:id/#{target.pluralize}" => "hunters#list#{target.pluralize}"
  end

  get 'hunters/:id/inventory' => "hunters#inventory"
  post 'hunters/:id/inventory' => "hunters#inventory"

  get 'hunters/:id/potentialskills' => 'hunters#potentialskills'
  post 'hunters/:id/potentialskills' => 'hunters#potentialskills'
  
  get 'hunters/:id/potentialproficiencies' => 'hunters#potentialproficiencies'
  post 'hunters/:id/potentialproficiencies' => 'hunters#potentialproficiencies'

  get 'hunters/:id/build' => 'hunters#build'
  get 'hunters/:id/share' => 'hunters#show'
  get 'hunters/:id' => 'hunters#edit'

  get 'hunters/index' => 'hunters#list'
  get 'hunters/' => 'hunters#list'
  get 'hunters' => 'hunters#list'

  get 'home/dashboard'

  get 'home/about'

  get 'home/pals'

  root 'home#dashboard'
  devise_for :users
end

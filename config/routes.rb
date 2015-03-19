Rails.application.routes.draw do
  
  get 'proficiency_templates/list'
  post 'proficiency_templates/list'
  
  get 'skill_templates/list'
  post 'skill_templates/list'

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

  get 'hunters/:id/skills' => 'hunters#skills'
  post 'hunters/:id/skills' => 'hunters#skills'
  
  targets = ["skills", "proficiencies", "attributes"]
  targets.each do |target|
    get "hunters/:id/#{target}/drop" => "hunters\#drop_#{target}"
    post "hunters/:id/#{target}/drop" => "hunters\#drop_#{target}"
    
    get "hunters/:id/#{target}/add" => "hunters\#add_#{target}"
    post "hunters/:id/#{target}/add" => "hunters\#add_#{target}"
    
    get "hunters/:id/#{target}/buy" => "hunters\#buy_#{target}"
    post "hunters/:id/#{target}/buy" => "hunters\#buy_#{target}"
    
    get "hunters/:id/#{target}/sell" => "hunters\#sell_#{target}"
    post "hunters/:id/#{target}/sell" => "hunters\#sell_#{target}"
  end

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

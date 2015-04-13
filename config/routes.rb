Rails.application.routes.draw do
  
  get 'gear/new'

  get 'gear/create'

  get 'gear/edit'

  get 'gear/index'

  get 'gear/_card'

  get 'gear/_instance_list'

  get 'gear/_instance_row'

  get 'gear/_template_list'

  get 'gear/_template_row'

  get 'consumables/new'

  get 'consumables/create'

  get 'consumables/edit'

  get 'consumables/index'

  get 'consumables/card'

  get 'minions/new'

  get 'minions/create'

  get 'minions/edit'

  get 'minions/index'

  get 'minions/card'

  get 'modifiers/new'

  get 'modifiers/create'

  get 'modifiers/edt'

  get 'modifiers/index'

  get 'proficiencies/new'

  get 'proficiencies/create'

  get 'proficiencies/edit'

  get 'proficiencies/index'

  get 'proficiencies/card'

  get 'races/new'

  get 'races/create'

  get 'races/edit'

  get 'races/index'
  get 'races/list'
  post 'races/list'

  get 'races/card'

  get 'weapons/new'

  get 'weapons/create'

  get 'weapons/index'

  get 'weapons/edit'

  get 'weapons/card'

  get 'skills/new'

  get 'skills/create'

  get 'skills/edit'
  get 'skills/edit_list'
  post 'skills/edit_list'

  get 'skills/index'

  get 'skills/card'

  get 'stacks/new'

  get 'stacks/create'

  get 'stacks/edit'

  get 'stacks/index'

  get 'stacks/card'

  get 'armor/new'

  get 'armor/create'

  get 'armor/edit'

  get 'armor/index'

  get 'armor/card'

  get 'shields/new'

  get 'shields/create'

  get 'shields/edit'

  get 'shields/index'

  get 'shields/card'

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
  
  targets = ["skill", "proficiency", "item"]
  targets.each do |target|
    get "hunters/:id/drop/#{target}" => "hunters\#drop#{target}"
    post "hunters/:id/drop/#{target}" => "hunters\#drop#{target}"
    
    get "hunters/:id/add/#{target}" => "hunters\#add#{target}"
    post "hunters/:id/add/#{target}" => "hunters\#add#{target}"
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

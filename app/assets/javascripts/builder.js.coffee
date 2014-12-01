# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

changed_attributes = {}
changed_proficiencies = {}
changed_skills = {}
new_race = null;
new_skills = []
changed_equipment ={}
changed_hunter = {}

@set_html_value = (id, value) ->
  $("#" + id).text(value.toString())

change_display_value = (id, val) ->
  points = Number($("#" + id).text())
  points += val
  $("#" + id).text(points.toString())
  
validate_change = (target_id, parent_id, value) ->
  points_left = Number($("#" + parent_id).text())
  result = points_left >= value
  current_points = Number($("#" + target_id).text())
  result &= (current_points + value) >= 0
  return result
  
validated_add = (target, parent_id) ->
  value = Number($("#" + target).text())
  value += 1
  if !validate_change(target, parent_id, 1)
    return false
  else
    @set_html_value(target, value)
    change_display_value(parent_id, -1)
    return true

validated_remove = (target, parent_id) ->
  value = Number($("#"+target).text())
  value -= 1
  if !validate_change(target, parent_id, -1)
    return false
  else
    @set_html_value(target, value)
    change_display_value(parent_id, 1)
    return true

@add_attribute_point = (id) ->
  target = "vh_build_attribute_" + id
  if validated_add(target, 'attribute_points')
    if !changed_attributes.hasOwnProperty(id)
      changed_attributes[id] = {'id': id, 'value': 1}
    else
      changed_attributes[id].value += 1
    return true
  else
    return false

@remove_attribute_point = (id) ->
  target = "vh_build_attribute_" + id
  if validated_remove(target, 'attribute_points')
    if !changed_attributes.hasOwnProperty(id)
      changed_attributes[id] = {'id': id, 'value': -1}
    else
      changed_attributes[id].value -= 1
    return true
  else
    return false
    
@select_race = (race_id) ->
  $("#vh_race_id").val(race_id)
  $("#race_name").val($("#race_name_" + race_id).val())
  new_race = race_id
  @clean_modals(false)
  
validate_new = (parent_id) ->
  points_left = Number($("#" + parent_id).text())
  return points_left > 0
  
change_proficiency = (id, value) ->
  if !changed_proficiencies.hasOwnProperty(id)
    changed_proficiencies[id] = {'id':id, 'value': value}
  else
    changed_proficiencies[id].value += value
  return true


update_proficiency = (id) ->
  target = "vh_build_proficiency_" +id
  if validated_add(target, 'proficiency_points')
    change_proficiency(id, 1)
  else
    return false
  
@undo_update_proficiency = (id) ->
  target = "vh_build_proficiency_" +id
  if validated_remove(target, 'proficiency_points')
    change_proficiency(id, -1)
  else
    return false

@build_proficiency = (template_id) ->
  if validate_new('proficiency_points')
    change_display_value('proficiency_points', -1)
    para = {vh: parseInt($('#vh_id').val()), parent: template_id, points: 1}
    @json_post '/proficiencies/create.json',
      para,
      (new_prof) ->
        build_prof_row(new_prof)
        change_proficiency(new_prof.id, 1)
        populate('proficiencies_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialproficiencies?mode=builder')

@drop_proficiency = (proficiency_id) ->
  success_callback =  () ->
    change_display_value('proficiency_points', 1)
    amount = parseInt($("#vh_build_proficiency_" + proficiency_id).text())
    change_proficiency(proficiency_id, -amount)
    $('#vh_build_prof_row_' + proficiency_id).remove()
    populate('proficiencies_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialproficiencies?mode=builder')
  post_callback = () ->
    @submit_post '/proficiencies/destroy',
      {confirm: 'yes', id: proficiency_id}
      success_callback
  confirm_dialog "It's against the rules to delete proficiencies, do you want \
  to proceed?",
    post_callback

@build_action = (template_id) ->
  if validate_new('skill_points')
    change_display_value('skill_points', -1)
    para = {vh: parseInt($('#vh_id').val()), parent: template_id}
    @json_post '/skills/create.json',
      para,
      (new_skill) ->
        new_skills.push({id: new_skill.id, status: 'added'})
        build_skill_row(new_skill)
        populate('action_skills_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialskills?mode=builder')

@drop_action = (skill_id) ->
  success_callback = () ->
    change_display_value('skill_points', 1)
    new_skills.push({id: skill.id, status: 'dropped'})
    $('#vh_build_skill_row_' + skill_id).remove()
    populate('action_skills_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialskills?mode=builder')
  post_callback = () ->
    @submit_post '/skills/destroy',
      {confirm: 'yes', id: skill_id}
      success_callback
  confirm_dialog "It's against the rules to delete action skills, do you want \
  to proceed?",
    post_callback

@advance = (target_id, callback) ->
  $('.toggler').hide()
  $('#'+target_id).show()
  if(callback != undefined)
    callback()

@populate = (target_id, url) ->
  $.ajax url,
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', \
      $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      $('#' + target_id).html(data)
    error: (jqXHR, status) ->
      $("#" + target_id).html(data)
      
@build_prof_row = (prof_object) ->
  profs = $("#proficiencies")
  row = $('<div></div>')
  row.addClass("row")
  if profs.children().length > 0
    if not profs.children().last().hasClass("vh_alt")
      row.addClass("vh_alt")
  row.attr("id", "vh_build_prof_row_" + prof_object.id)
  row.append(insert_content_div("col-md-5 vh_build_large", prof_object.name))
  row.append(insert_content_div("col-md-1 vh_build_huge", prof_object.tier, \
  "vh_build_proficiency_" + proficiency.id))
  adder = insert_content_div("col-md-1 vh_build_huge", "+")
  adder.on click: new Function("update_proficiency(" + prof_object.id + ")")
  row.append(adder)
  del = insert_content_div("col-md-1", "<img src='/images/delete.png'></img>")
  del.on click: new Function("drop_proficiency(" + prof_object.id + ")")
  row.append(del)
  row.append(insert_content_div("col-md-3", ""))
  profs.append(row)
  return row

@build_skill_row = (skill_object) ->
  skills = $('#skills')
  row = $('<div></div>')
  if skills.children().length > 0
    if not skills.children().last().hasClass("vh_alt")
      row.addClass('vh_alt')
  row.addClass('row')
  row.attr("id", 'vh_build_skill_row_' + skill_object.id)
  row.append(insert_content_div("col-md-11 vh_build_large", skill_object.name))
  del = insert_content_div("col-md-1", "<img src='/images/delete.png'></img>")
  del.on click: new Function("drop_action(" + skill_object.id + ")")
  row.append(del)
  skills.append(row)
  return row
  

insert_content_div = (class_name, content, id) ->
  div = $('<div></div>')
  div.addClass(class_name)
  div.html(content)
  if id != undefined
    div.attr('id', id)
  return div

@builder_review = () ->
  vh_package = {}
  @package_attributes(vh_package)
  @package_description(vh_package)
  @package_proficiencies(vh_package)
  @package_skills(vh_package)
  @package_equipment(vh_package)
  
  build_modal("verify-window")
  item = $("<div class='row'></div>")
  item.append($("<div class='col-md-12 text-center'>Checking changes with server...</div>"))
  item.append($("<div class='col-md-12'><img src='/images/ajax-loader.gif'></img></div>"))
  $("#verify-window").append(item)
  
  verify_success = (html_result) ->
    clean_modals()
    build_modal("success-window")
    $("#success-window").append("<h1>Save Success</h1>")
  
  @html_post '/hunters/' + parseInt($('#vh_id').val()) + '/verify',
    vh_package
    verify_success

find_unique_ids = (hash) ->
  uniq = {}
  for entry in hash 
    el = entry.id;
    if ( !uniq[el] )
      uniq[el] = []
    uniq[el].push(entry);
  return uniq

@package_attributes = (vh_package) ->
  vh_package['attributes'] = changed_attributes
  
@package_description = (vh_package) ->
  changed_hunter['description'] = $("vh_builder_description").val()
  changed_hunter['background'] =$("vh_builder_background").val()
  changed_hunter['flaws'] =$("vh_builder_flaws").val()
  changed_hunter['traits'] =$("vh_builder_traits").val()
  vh_package['hunter'] = changed_hunter
  
@package_proficiencies = (vh_package) ->
  vh_package['proficiencies'] = changed_proficiencies
  
@package_skills = (vh_package) ->
  vh_package['skills'] = new_skills
  
@package_equipment = () ->
  #Stub
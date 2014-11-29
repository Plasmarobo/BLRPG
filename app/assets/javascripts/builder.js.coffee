# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

changed_attributes = {}
changed_proficiencies = []
new_proficiencies = []
new_skills = []
new_race = []
changed_equipment =[]
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
  
@valdiated_add = (target, parent_id) ->
  value = Number($("#" + target).text())
  value += 1
  if !validate_change(target, parent_id, 1)
    return false
  else
    @set_html_value(target, value)
    change_display_value(parent_id, -1)
    return true

@validated_remove = (target, parent_id) ->
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
  if @validated_add(target, 'attribute_points')
    if !changed_attributes.hasOwnProperty(id)
      changed_attributes[id] = {'id': id, 'value': 1}
    else
      changed_attributes[id].value += 1
    return true
  else
    return false

@remove_attribute_point = (id) ->
  target = "vh_build_attribute_" + id
  if @validated_remove(target, 'attribute_points')
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
  @clean_modals(false)

@package_description = () ->
  changed_hunter['description'] = $("vh_builder_description").val()
  changed_hunter['background'] =$("vh_builder_background").val()
  changed_hunter['flaws'] =$("vh_builder_flaws").val()
  changed_hunter['traits'] =$("vh_builder_traits").val()
  
validate_new = (parent_id) ->
  points_left = Number($("#" + parent_id).text())
  return points_left > 0

@update_proficiency = (id) ->
  target = "vh_build_proficiency_" +id
  if @validated_add(target, 'proficiency_points')
    if !changed_proficiencies.hasOwnProperty(id)
      changed_proficiencies[id] = {'id':id, 'value': 1}
    else
      changed_proficiencies[id].value += 1
    return true
  else
    return false
  
@undo_update_proficiency = (id)
  target = "vh_build_proficiency_" +id
  if @validated_remove(target, 'proficiency_points')
    if !changed_proficiencies.hasOwnProperty(id)
      changed_proficiencies[id] = {'id':id, 'value': -1}
    else
      changed_proficiencies[id].value -= 1
    return true
  else
    return false

@build_proficiency = (template_id) ->
  if validate_new('proficiency_points')
    change_display_value('proficiency_points', -1)
    new_proficiencies.push({id: template_id})
    para = {vh: parseInt($('#vh_id').val()), parent: template_id, points: 1}
    @json_post 'proficiencies/create.json', 
      para
      (new_prof) ->
        build_prof_row(new_prof)

@undo_build_proficiency = (proficiency_id) ->
  confirm_dialog("It's against the rules to delete proficiencies, do you want to proceed?", 
    (proficiency_id) ->
      @json_post 'proficiencies/destroy',
        {confirm: 'yes', id: proficiency_id}
        () ->
          change_display_value('proficiency_points', 1)
          $('#vh_build_proficiency_' + proficiency_id).remove()

@build_skill = (template_id) ->
  if validate_new('skill_points')
    change_display_value('skill_points', -1)
    new_skills.push({id: template_id})
    para = {vh: parseInt($('#vh_id').val()), parent: template_id}
    @json_post 'skills/create.json', 
      para
      (new_skill) ->
        build_skill_row(new_skill)

@undo_build_skill = (skill_id) ->
  confirm_dialog("It's against the rules to delete action skills, do you want to proceed?",
    (skill_id) ->
      @json_post 'skills/destroy',
        {confirm: 'yes', id: skill_id}
        () ->
          change_display_value('skill_points', 1)
          $('#vh_build_proficiency_' + skill_id).remove()

@advance = (target_id, callback) ->
  $('.toggler').hide()
  $('#'+target_id).show()
  if(callback != undefined)
    callback()

@populate = (target_id, url) ->
  $.ajax url,
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      $('#' + target_id).append(data)
    error: (jqXHR, status) ->
      $("#" + target_id).append(data);
      
@build_prof_row = (prof_object) ->
  profs = $("#proficiencies")
  row = $('<div></div>')
  row.addClass("row")
  if profs.children().length > 0
    if not profs.children().last().hasClass("vh_alt")
      row.addClass("vh_alt")
  row.append(insert_content_div("col-md-5 vh_build_large", prof_object.name);
  row.append(insert_content_div("col-md-1 vh_build_huge", prof_object.tier, "vh_build_proficiency_" + proficiency.id))
  row.append(insert_content_div("col-md-1 vh_build_huge", "+"))
  row.children().last().click () ->
    update_proficiency(prof_object.id)
  row.append(insert_content_div("col-md-4", ""))
  row.on('oncontextmenu', () ->
    undo_build_proficiency(prof_object.id)
  profs.append(row)
  return row
  
@build_skill_row = (skill_object) ->
  skills = $('#skills')
  row = $('<div></div>')
  if skills.children().length > 0
    if not skills.children().last().hasClass("vh_alt")
      row.addClass('vh_alt')
  row.addClass('row')

insert_content_div = (class_name, content, id = null) ->
  div = $('<div></div>')
  div.addClass(class_name)
  div.html(content)
  if id != null
    div.attr('id', id)
  return div
      
@builder_review = () ->
  
  
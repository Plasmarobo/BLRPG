# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
  return validated_add(target, 'attribute_points')

@remove_attribute_point = (id) ->
  target = "vh_build_attribute_" + id
  return validated_remove(target, 'attribute_points')
    
@upload_attributes = (callback) ->
  attribs = {}
  attrib_regex = /([0-9]+)/
  $.each $("[id^='vh_build_attribute_']"), (index,field) ->
    properties = field.id.match(attrib_regex)
    id = properties[1]
    attribs[id] = parseInt(field.textContent)
  @submit_post '/attribute_instances/validate_batch',
    {attribute_instances: attribs}
    callback
  
@upload_hunter = (callback) ->
  hunter = {}
  hunter['description'] = $("#vh_builder_description").val()
  hunter['background'] =$("#vh_builder_background").val()
  hunter['flaws'] =$("#vh_builder_flaws").val()
  hunter['traits'] =$("#vh_builder_traits").val()
  hunter['race_id'] =$("#vh_race_id").val()
  hunter['id'] =$("#vh_id").val()
  @submit_post '/hunters/' + hunter.id + '/update',
    {vault_hunter: hunter}
    callback
  
validate_new = (parent_id) ->
  points_left = Number($("#" + parent_id).text())
  return points_left > 0

@update_proficiency = (id) ->
  target = "vh_build_proficiency_" +id
  return validated_add(target, 'proficiency_points')
  
@undo_update_proficiency = (id) ->
  target = "vh_build_proficiency_" +id
  return validated_remove(target, 'proficiency_points')

@build_proficiency = (template_id) ->
  if validate_new('proficiency_points')
    change_display_value('proficiency_points', -1)
    para = {vh: parseInt($('#vh_id').val()), parent: template_id, points: 1}
    @json_post '/proficiencies/validated_create.json',
      para,
      (new_prof) ->
        build_prof_row(new_prof)
        populate('proficiencies_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialproficiencies?mode=builder')

@drop_proficiency = (proficiency_id) ->
  success_callback =  () ->
    amount = parseInt($("#vh_build_proficiency_" + proficiency_id).text())
    change_display_value('proficiency_points', amount)
    $('#vh_build_prof_row_' + proficiency_id).remove()
    populate('proficiencies_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialproficiencies?mode=builder')
  post_callback = () ->
    @submit_post '/proficiencies/drop',
      {confirm: 'yes', id: proficiency_id}
      success_callback
  confirm_dialog "It's against the rules to delete proficiencies, do you want \
  to proceed?",
    post_callback
    
@upload_proficiencies = (callback) ->
  profs = {}
  profs_regex = /([0-9]+)/
  $.each $("[id^='vh_build_proficiency_']"), (index,field) ->
    properties = field.id.match(profs_regex)
    id = properties[1]
    profs[id] = {id: id, tier: parseInt(field.textContent)}
  @submit_post '/proficiencies/validate_batch',
    {proficiencies: profs}
    callback

@build_action = (template_id) ->
  if validate_new('skill_points')
    change_display_value('skill_points', -1)
    para = {vh: parseInt($('#vh_id').val()), parent: template_id}
    @json_post '/skills/validated_create.json',
      para,
      (new_skill) ->
        build_skill_row(new_skill)
        populate('action_skills_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialskills?mode=builder')

@drop_action = (skill_id) ->
  success_callback = () ->
    change_display_value('skill_points', 1)
    $('#vh_build_skill_row_' + skill_id).remove()
    populate('action_skills_window', '/hunters/' + parseInt($('#vh_id').val()) + '/potentialskills?mode=builder')
  post_callback = () ->
    @submit_post '/skills/drop',
      {confirm: 'yes', id: skill_id}
      success_callback
  confirm_dialog "It's against the rules to delete action skills, do you want \
  to proceed?",
    post_callback

@upload_equipment = (callback) ->
  #stup
  callback()

@show_sheet_link = () ->
  build_modal("link-window")
  $("#link-window").append($("<div class='container mwin text-center'><a href='/hunters/" + parseInt($("#vh_id").val()) + "' class='btn btn-success btn-huge'>View Sheet</a></div>"))
  $("#link-window").modal("show")

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
  "vh_build_proficiency_" + prof_object.id))
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


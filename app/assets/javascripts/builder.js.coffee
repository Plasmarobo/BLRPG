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

@add_attribute_point = (id) ->
  value = Number($("#vh_build_attribute_" + id).html())
  value += 1
  if changed_attributes.hasOwnProperty(id)
    changed_attributes[id] = {'id': id, 'value': value}
  else
    changed_attributes[id].value = value

@remove_attribute_point = (id) ->
  value = Number($("#vh_build_attribute_" + id).html())
  value -= 1
  if changed_attributes.hasOwnProperty(id)
    changed_attributes[id] = {'id': id, 'value': value}
  else
    changed_attributes[id].value = value

@package_description = () ->
  changed_hunter['description'] = $("vh_builder_description").val()
  changed_hunter['background'] =$("vh_builder_background").val()
  changed_hunter['flaws'] =$("vh_builder_flaws").val()
  changed_hunter['traits'] =$("vh_builder_traits").val()

@update_proficiency = (id) ->

@add_proficiency = (template_id) ->
  target = 'proficiencies'
  para = {vh: parseInt($('#vh_id').val()), parent: template_id, points: 0}
  @transact_into('/proficiencies/create', para, target)

@add_action = (template_id) ->
  target = 'actions'
  para = {vh: parseInt($('#vh_id').val()), parent: template_id}
  @transact_into('/skills/create', para, target)

@select_race = (race_id) ->
  $("#vh_race_id").val(race_id)
  $("#race_name").val($("#race_name_" + race_id).val())
  @clean_modals(false)

@advance = (target_id, callback) ->
  $('.toggler').hide()
  $('#'+target_id).show()
  if(callback != null)
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
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
dirtyAttributes = 0
dirtyDescription = 0
dirtyProficiencies = 0
dirtySkills = 0
changed_attributes = {}
changed_proficiencies = {}
new_race = {}
changed_description = {}
new_proficiencies = {}
new_skills = {}


@add_attribute_point = (id) ->

@remove_attribute_point = (id) ->


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
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@add_attack = (skill_id) ->
  alert(skill_id)

@add_proficiency = (template_id) ->
  alert(template_id)

@add_action = (template_id) ->
  alert(template_id)

@package_sheet_changes = () ->
  namespace_inputs = $("[id^='vh_']");
  prof_regex = /proficiency_([a-z]+)_([0-9]+)/
  attack_regex = /attack_([a-z]+)_([0-9]+)/
  attrib_regex = /attrib_([0-9]+)/
  hunter = {}
  attacks = {}
  proficiencies = {}
  skills = {}
  attribs = {}

  $.each namespace_inputs, (index,field) ->
    ns_name = field.id.substr(3)
    if ns_name.substr(0,11) == "proficiency"
      properties = ns_name.match(prof_regex)
      id = properties[2]
      key = properties[1]
      if not (id in proficiencies)
        proficiencies[id] = {pool: 0, points: 0}
      proficiencies[id][key] = field.value
    else if ns_name.substr(0, 6) == "attack"
      properties = ns_name.match(attack_regex)
      id = properties[2]
      key = properties[1]
      if not (id in attacks)
        attacks[id] = {name: "error_name", pool: 0, dmg: 0}
      attacks[id][key] = field.value
    else if ns_name.substr(0, 6) == "attrib"
      properties = ns_name.match(attrib_regex)
      id = properties[1]
      attribs[id] = field.value
    else
      hunter[ns_name] = field.value
    
  result = 
  {
    vault_hunter:  hunter,
    proficiencies: proficiencies,
    attacks:       attacks,
    skills:        skills,
    attributes:    attribs
  }
  return result;

@json_post = (url, payload, success_callback) ->
  $.ajax url,
    type: 'POST'
    dataType: 'json'
    data: payload
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: success_callback
    error: (jqXHR, status) ->
      build_modal("error-window")
      $("#error-window").append(status);

@set_modal_list = (id, url) ->
  div = $('<div>', {class: 'container mwin'});
  $("#" + id).html("");
  $.ajax url,
    type: 'GET'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      div.append(data)
      $("#" +id).append(div);
    error: (jqXHR, status) ->
      div.append(status)
      $("#" + id).append(div);

@clean_modals = () ->
  $('.modal').remove()

@build_modal = (id) ->
  clean_modals()
  div = $('<div class=\"modal fade\" id=\"' + id + '\" role=\"dialog\" aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >')
  $('body').append(div)

@upload_vault_hunter = (id, vault_objects, callback) ->
  $("#target").html("5")
  $("#count").html("0")
  json_post '/hunters/' + id + '/update',
            {vault_hunter: vault_objects.vault_hunter}
            () ->
              $("#count").html("1")
              json_post '/proficiencies/batch',
                {proficiencies: vault_objects.proficiencies}
                () ->
                  $("#count").html("2")
                  json_post '/skills/batch',
                    {skills: vault_objects.skills}
                    () ->
                      $('#count').html("3")
                      json_post '/attacks/batch',
                        {attacks: vault_objects.attacks}
                        () ->
                          $("#count").html("4")
                          json_post '/attribute_instances/update',
                            {attribute_instances: vault_objects.attribs}
                            () ->
                              $("#count").html("5")
                              $("#save_dialog").append("<h1>Success!</h1>")


  
@save_vault_hunter = (id) ->
  @build_modal("save_dialog")
  $("#save_dialog").html("<h1>Saving, please wait</h1><span id='count'>0</span><span id='target'>0</span>");
  vault_objects = package_sheet_changes()
  close_save_dialog = () ->
    $("#save_dialog").modal('hide');
  upload_vault_hunter(id, vault_objects, close_save_dialog)

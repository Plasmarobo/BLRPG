# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@select_race = (race_id) ->
  $("#vh_race_id").val(race_id)
  $("#race_name").val($("#race_name_" + race_id).val())
  @clean_modals(false)
  
@add_attack = (skill_id) ->
  target = 'attacks'
  para = {vh: parseInt($('#vh_id').val()), parent: skill_id}
  @transact_into('/attacks/create',para, target)
  @clean_modals(false)

@delete_attack = (attack_id) ->
  del_callback = () ->
    @json_post '/attacks/destroy', 
      {confirm: "yes", id: attack_id}
      () ->
        $("#attack_" + attack_id).remove()
  @confirm_dialog("You are about to delete this attack forever, continue?", del_callback)
  false

@add_proficiency = (template_id) ->
  target = 'proficiencies'
  para = {vh: parseInt($('#vh_id').val()), parent: template_id, points: 0}
  @transact_into('/proficiencies/create', para, target)
  @clean_modals(false)
  
@delete_proficiency = (proficiency_id) ->
  del_callback = () ->
    @json_post '/proficiencies/destroy', 
      {confirm: "yes", id: proficiency_id}
      () -> 
        $("#proficiency_" + proficiency_id).remove()
  @confirm_dialog("You are about to delete this proficiency forever, continue?", del_callback)
  false

@add_action = (template_id) ->
  target = 'actions'
  para = {vh: parseInt($('#vh_id').val()), parent: template_id}
  @transact_into('/skills/create', para, target)
  @clean_modals(false)
  
@delete_action = (action_id) ->
  del_callback = () ->
    @json_post '/skills/destroy', 
      {confirm: "yes", id: action_id}
      () -> 
        $("#action_" + action_id).remove()
  @confirm_dialog("You are about to delete this action forever, continue?", del_callback)
  false
  
@add_minion = () ->
  target = 'minions'
  para = {vh: parseInt($('#vh_id').val())}
  @transact_into('/minions/create',para, target)

@delete_minion = (minion_id) ->
  del_callback = () ->
    @json_post '/minions/destroy', 
      {confirm: "yes", id: action_id}
      () -> 
        $("#minion_" + minion_id).remove()
  @confirm_dialog("You are about to delete this minion forever, continue?", del_callback)
  false

@package_sheet_changes = () ->
  namespace_inputs = $("[id^='vh_']");
  prof_regex = /proficiency_([a-z]+)_([0-9]+)/
  minion_regex = /minion_([a-z]+)_([0-9]+)/
  attack_regex = /attack_([a-z]+)_([0-9]+)/
  attrib_regex = /attrib_([0-9]+)/
  hunter = {}
  attacks = {}
  minions = {}
  proficiencies = {}
  skills = {}
  attribs = {}

  $.each namespace_inputs, (index,field) ->
    ns_name = field.id.substr(3)
    if ns_name.substr(0,11) == "proficiency"
      properties = ns_name.match(prof_regex)
      id = properties[2]
      key = properties[1]
      if not (proficiencies.hasOwnProperty(id))
        proficiencies[id] = {}
      (proficiencies[id])[key] = field.value
    else if ns_name.substr(0, 6) == "minion"
      properties = ns_name.match(minion_regex)
      id = properties[2]
      key = properties[1]
      if not (minions.hasOwnProperty(id))
        minions[id] = {}
      (minions[id])[key] = field.value
    else if ns_name.substr(0, 6) == "attack"
      properties = ns_name.match(attack_regex)
      id = properties[2]
      key = properties[1]
      if not (attacks.hasOwnProperty(id))
        attacks[id] = {}
      (attacks[id])[key] = field.value
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
    attributes:    attribs,
    minions:       minions
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
  @query_into(url, id, div)

@transact_into = (url, params, target, base = null) ->
  $.ajax url,
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    data: params
    dataType: 'html'
    success: (data) ->
      if base != null
        base.append(data)
      else
        base = data
      $("#" + target).append(base);
    error: (jqXHR, status) ->
      if base != null
        base.append(status)
      else
        base = status
      $("#" + target).append(status);

@query_into = (url, target, base = null) ->
  $.ajax url,
    type: 'GET'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      if base != null
        base.append(data)
      else
        base = data
      $("#" + target).append(base);
    error: (jqXHR, status) ->
      if base != null
        base.append(data)
      else
        base = data
      $("#" + target).append(base);

@clean_modals = (include_error) ->
  set = $('.modal')
  if include_error
    set.remove()
  else
    set.not('#error-window').remove()
  $('body').removeClass("modal-open")

@build_modal = (id) ->
  clean_modals()
  div = $('<div class=\"modal fade\" id=\"' + id + '\" role=\"dialog\" aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >')
  $('body').append(div)

@upload_vault_hunter = (id, vault_objects, callback) ->
  $("#target").html("6")
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
                          json_post '/attribute_instances/batch',
                            {attribute_instances: vault_objects.attributes}
                            () ->
                              $("#count").html("5")
                              json_post '/minions/batch',
                                {minions: vault_objects.minions}
                                () ->
                                  $("#count").html("6")
                                  callback()
  
@save_vault_hunter = (id) ->
  build_modal("save_dialog")
  $("#save_dialog").modal('show');
  $("#save_dialog").append("<div class='container mwin'><h1>Saving, please wait</h1><span id='count'>0</span>/<span id='target'>0</span></div>");
  vault_objects = package_sheet_changes()
  close_save_dialog = () ->
    $("#save_dialog").modal('hide');
  upload_vault_hunter(id, vault_objects, close_save_dialog)
  
@confirm_dialog = (message, y_callback) ->
  build_modal("confirm")
  $("#confirm").modal('show')
  $("#confirm").append("<div class='container mwin'><h1>Are you sure?</h1><p>"+message+"</p><button id='yes_btn' class='btn btn-default'>Yes</button><button id='cancel_btn' class='btn btn-default'>Cancel</button></div>")
  $("#yes_btn").click () ->
    y_callback()
    clean_modals(false)
  $("#cancel_btn").click () ->
    clean_modals(false)
  false

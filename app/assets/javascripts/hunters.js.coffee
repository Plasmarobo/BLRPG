# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@VaultHunterId = 0;
@CurrentUserId = 0;

@set_vault_hunter = (id) ->
  VaultHunterId = id;

@set_user_id = (id) ->
  CurrentUserId = id;

@add_attack = (skill_id) ->
  alert(skill_id)

@add_proficiency = (template_id) ->
  alert(template_id)

@add_action = (template_id) ->
  alert(template_id)

@package_sheet_changes = () ->
  namespace_inputs = $("[id^=vh_");
  namespace = {}

  $.each namespace_inputs, (field) ->
    ns_name = field.id.substr(3)
    namespace[ns_name] = field.value

  VaultHunterObject =
  {
    name: namespace.name,
    user_id: CurrentUserId,
    age: namespace.age,
    race: namespace.race,
    height: namespace.height,
    weight: namespace.weight,
    toughness: namespace.toughness,
    wounds: namespace.wounds,
    shield: namespce.shield,
    current_shield: namespace.current_shield,
    loot: namespace.loot,
    money: namespace.money,
    level: namespace.level
  }
  AttackObjects = []
  SkillObjects = []
  ProficiencyObjects = []
  result = 
  {
    vault_hunter:  VaultHunterObject,
    proficiencies: ProficiencyObjects,
    skills:        SkillObjects,
    attacks:       AttackObjects
  }
  return result;

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
      div.append(data)
      $("#" + id).append(div);

@clean_modals = () ->
  $('.modal').remove()

@build_modal = (id) ->
  clean_modals()
  div = $('<div class=\"modal fade\" id=\"' + id + '\", role=\"dialog\", aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >')
  $('body').append(div)


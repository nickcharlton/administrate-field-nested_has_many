//= require cocoon
$(document).on('ready page:load turbolinks:load turbo:load cocoon:after-insert', function() {
  $('.field-unit--select select').selectize({});
  $('.field-unit--belongs-to select').selectize({});
  $(".field-unit--has-many select").selectize({});
  $('.field-unit--polymorphic select').selectize({});
});

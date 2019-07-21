// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui   
//= require jquery_ujs
//= require popper
//= require moment
//= require bootstrap
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
//= require material-dashboard
//= require bootstrap-material-design.min
//= require bootstrap-selectpicker
//= require nouislider.min
//= require bootstrap-datetimepicker.min
//= require material
//= require material-kit
//= require maskedinput
//= require maskmoney   
//= require notify
//= require jquery.tagsinput
//= require Chart.bundle
//= require chartkick
//= require trix

$(document).ready(function($) {
    /* Pesquisa Ransack */
    $(document).on('click', '[data-submit-form]', function(e) {
        e.preventDefault();
        $(this).closest('form').submit();
    });

    /*
    if($(event.target).closest('.open-dropdown').length==0){
        $('li').removeClass("open-dropdown");         
    };*/
    
});
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
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require now-ui-kit
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap-select
//= require Chart.bundle
//= require chartkick
//= require material
//= require material-kit
//= require bootstrap-datepicker
//= require maskedinput
//= require maskmoney   
//= require notify
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
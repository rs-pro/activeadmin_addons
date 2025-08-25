// ActiveAdmin Addons for backward compatibility
//= require jquery
//= require slim-select
//= require jquery-datetimepicker

(function($) {
  'use strict';
  
  // Import modules using traditional approach
  const initializeActiveAdminAddons = function() {
    // Initialize Slim Select components
    const selects = document.querySelectorAll('select.slim-select:not([data-slim-select-initialized])');
    selects.forEach(function(select) {
      select.setAttribute('data-slim-select-initialized', 'true');
    });
    
    // Initialize other components
    if (typeof window.activeadmin_addons !== 'undefined' && window.activeadmin_addons.initializeAll) {
      window.activeadmin_addons.initializeAll();
    }
  };
  
  // Initialize on DOM ready
  $(document).ready(function() {
    initializeActiveAdminAddons();
  });
  
  // Reinitialize on Turbo/Turbolinks events
  $(document).on('turbo:load turbolinks:load', function() {
    initializeActiveAdminAddons();
  });
  
  // Initialize for ActiveAdmin's dynamic content
  $(document).on('has_many_add:after', '.has_many_container', function() {
    initializeActiveAdminAddons();
  });
  
})(jQuery);
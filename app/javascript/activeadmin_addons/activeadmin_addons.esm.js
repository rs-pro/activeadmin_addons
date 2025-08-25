// ActiveAdmin Addons ESM Module for ActiveAdmin 4
import $ from 'jquery';
import SlimSelect from 'slim-select';
import 'jquery-datetimepicker';

// Ensure jQuery is globally available
window.$ = window.jQuery = $;

// Import main components
import './vendor/jquery_palette_color_picker/palette-color-picker';
import './config';
import './inputs/slim-select';
import './inputs/date-time-picker';
import './inputs/color-picker';
import './addons/toggle_bool';
import './addons/slim-select-interactive-tag';

// Initialize on DOM ready
$(() => {
  initializeActiveAdminAddons();
  
  // Reinitialize on Turbo/Turbolinks events
  $(document).on('turbo:load turbolinks:load', () => {
    initializeActiveAdminAddons();
  });
  
  // Initialize for ActiveAdmin's dynamic content
  $(document).on('has_many_add:after', '.has_many_container', () => {
    initializeActiveAdminAddons();
  });
});

function initializeActiveAdminAddons() {
  // Initialize Slim Select components
  const selects = document.querySelectorAll('select.slim-select:not([data-slim-select-initialized])');
  selects.forEach(select => {
    select.setAttribute('data-slim-select-initialized', 'true');
    // Slim Select initialization handled in slim-select.js
  });
  
  // Initialize other components that need re-initialization
  if (typeof window.activeadmin_addons !== 'undefined' && window.activeadmin_addons.initializeAll) {
    window.activeadmin_addons.initializeAll();
  }
}

export default initializeActiveAdminAddons;
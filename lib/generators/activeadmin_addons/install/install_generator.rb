require 'rails/generators'

module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      
      class_option :bundler,
                   type: :string,
                   default: 'auto',
                   enum: %w[auto esbuild importmap webpack sprockets],
                   desc: 'Choose your bundler: esbuild, importmap, webpack, or sprockets (auto will detect)'

      def create_initializer
        template "initializer.rb", "config/initializers/activeadmin_addons.rb"
      end

      def setup_assets
        bundler_type = detect_bundler
        
        case bundler_type
        when 'esbuild'
          setup_esbuild
        when 'importmap'
          setup_importmap
        when 'webpack'
          setup_webpack
        when 'sprockets'
          setup_sprockets
        else
          say "Could not detect bundler type. Please set up assets manually.", :red
          print_manual_instructions
        end
        
        say "\nActiveAdmin Addons has been configured for #{bundler_type}!", :green
        say "Don't forget to restart your Rails server!", :yellow
      end
      
      private
      
      def detect_bundler
        return options[:bundler] unless options[:bundler] == 'auto'
        
        if File.exist?('config/importmap.rb')
          'importmap'
        elsif File.exist?('app/javascript/active_admin.js') || File.exist?('app/javascript/application.js')
          if File.exist?('package.json')
            package_json = File.read('package.json')
            if package_json.include?('esbuild')
              'esbuild'
            elsif package_json.include?('webpack')
              'webpack'
            else
              'esbuild' # Default for modern JS bundling
            end
          else
            'esbuild'
          end
        elsif File.exist?('app/assets/javascripts/active_admin.js')
          'sprockets'
        else
          nil
        end
      end
      
      def setup_esbuild
        say "Setting up ActiveAdmin Addons for esbuild...", :blue
        
        # Add to package.json dependencies
        if File.exist?('package.json')
          say "Installing npm dependencies...", :yellow
          run "npm install --save slim-select@^2.9.2 jquery-datetimepicker@^2.5.21 lodash.merge@^4.6.2"
        end
        
        # Add imports to app/javascript/active_admin.js
        active_admin_js = 'app/javascript/active_admin.js'
        if File.exist?(active_admin_js)
          inject_into_file active_admin_js, after: /^import ['"]@activeadmin\/activeadmin['"];?\n/ do
            <<~JS
              
              // ActiveAdmin Addons imports
              import $ from 'jquery';
              import SlimSelect from 'slim-select';
              import 'jquery-datetimepicker';
              
              // Initialize jQuery globally
              window.$ = window.jQuery = $;
              
              // Import ActiveAdmin Addons
              import 'activeadmin_addons/activeadmin_addons.esm';
              
              // Import CSS
              import 'slim-select/dist/slimselect.css';
              import 'jquery-datetimepicker/jquery.datetimepicker.css';
            JS
          end
        else
          say "Please add the imports to your active_admin.js file manually", :red
          print_esbuild_instructions
        end
      end
      
      def setup_importmap
        say "Setting up ActiveAdmin Addons for importmap...", :blue
        
        # Add pins to config/importmap.rb
        if File.exist?('config/importmap.rb')
          inject_into_file 'config/importmap.rb', before: /^end\s*$/ do
            <<~RUBY
              
              # ActiveAdmin Addons dependencies
              pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"
              pin "slim-select", to: "https://cdn.jsdelivr.net/npm/slim-select@2.9.2/dist/slimselect.es.js"
              pin "jquery-datetimepicker", to: "https://cdn.jsdelivr.net/npm/jquery-datetimepicker@2.5.21/build/jquery.datetimepicker.full.min.js"
              pin "lodash.merge", to: "https://cdn.jsdelivr.net/npm/lodash.merge@4.6.2/index.js"
              pin "activeadmin_addons", to: "activeadmin_addons/activeadmin_addons.esm.js"
            RUBY
          end
        end
        
        # Add initialization to application.js
        if File.exist?('app/javascript/application.js')
          append_to_file 'app/javascript/application.js' do
            <<~JS
              
              // ActiveAdmin Addons initialization
              import "jquery"
              import "slim-select"
              import "jquery-datetimepicker"
              import "activeadmin_addons"
            JS
          end
        end
        
        say "\nIMPORTANT: Add the following CSS links to your layout or ActiveAdmin initializer:", :yellow
        say <<~HTML
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slim-select@2.9.2/dist/slimselect.css">
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-datetimepicker@2.5.21/jquery.datetimepicker.css">
        HTML
      end
      
      def setup_webpack
        say "Setting up ActiveAdmin Addons for webpack...", :blue
        
        # Add to package.json
        if File.exist?('package.json')
          say "Installing npm dependencies...", :yellow
          run "npm install --save slim-select@^2.9.2 jquery@^3.7.1 jquery-datetimepicker@^2.5.21 lodash.merge@^4.6.2"
        end
        
        # Try both possible webpack entry points
        webpack_entry = if File.exist?('app/javascript/packs/active_admin.js')
                          'app/javascript/packs/active_admin.js'
                        elsif File.exist?('app/javascript/active_admin.js')
                          'app/javascript/active_admin.js'
                        else
                          nil
                        end
        
        if webpack_entry
          inject_into_file webpack_entry, after: /^import ['"]@activeadmin\/activeadmin['"];?\n/ do
            <<~JS
              
              // ActiveAdmin Addons
              import $ from 'jquery';
              window.$ = window.jQuery = $;
              
              import 'activeadmin_addons/activeadmin_addons.esm';
              import 'slim-select/dist/slimselect.css';
              import 'jquery-datetimepicker/jquery.datetimepicker.css';
            JS
          end
        else
          say "Please add the imports to your webpack entry file manually", :red
          print_webpack_instructions
        end
      end
      
      def setup_sprockets
        say "Setting up ActiveAdmin Addons for Sprockets (legacy)...", :blue
        
        # Add to app/assets/javascripts/active_admin.js
        js_file = if File.exist?('app/assets/javascripts/active_admin.js')
                    'app/assets/javascripts/active_admin.js'
                  elsif File.exist?('app/assets/javascripts/active_admin.js.coffee')
                    'app/assets/javascripts/active_admin.js.coffee'
                  else
                    nil
                  end
        
        if js_file
          if js_file.end_with?('.coffee')
            append_to_file js_file do
              "\n#= require activeadmin_addons/all\n"
            end
          else
            append_to_file js_file do
              "\n//= require activeadmin_addons/all\n"
            end
          end
        end
        
        # Add to app/assets/stylesheets/active_admin.scss
        if File.exist?('app/assets/stylesheets/active_admin.scss')
          inject_into_file 'app/assets/stylesheets/active_admin.scss', 
                          before: /^\/\/ Active Admin's got SASS!/ do
            <<~SCSS
              // ActiveAdmin Addons styles
              @import 'activeadmin_addons/all';
              
            SCSS
          end
        end
      end
      
      def print_manual_instructions
        say <<~INSTRUCTIONS
          
          Manual Setup Instructions:
          ==========================
          
          For esbuild/webpack:
          1. Install NPM packages: npm install --save slim-select jquery-datetimepicker lodash.merge
          2. Add to your active_admin.js:
             import 'activeadmin_addons/activeadmin_addons.esm';
          
          For importmap:
          1. Add pins to config/importmap.rb (see documentation)
          2. Import in your application.js
          
          For sprockets:
          1. Add to active_admin.js: //= require activeadmin_addons/all
          2. Add to active_admin.scss: @import 'activeadmin_addons/all';
        INSTRUCTIONS
      end
      
      def print_esbuild_instructions
        say <<~INSTRUCTIONS
          
          Add to your app/javascript/active_admin.js:
          
          import $ from 'jquery';
          import 'activeadmin_addons/activeadmin_addons.esm';
          import 'slim-select/dist/slimselect.css';
          import 'jquery-datetimepicker/jquery.datetimepicker.css';
          
          window.$ = window.jQuery = $;
        INSTRUCTIONS
      end
      
      def print_webpack_instructions
        say <<~INSTRUCTIONS
          
          Add to your webpack entry file:
          
          import $ from 'jquery';
          window.$ = window.jQuery = $;
          import 'activeadmin_addons/activeadmin_addons.esm';
          import 'slim-select/dist/slimselect.css';
          import 'jquery-datetimepicker/jquery.datetimepicker.css';
        INSTRUCTIONS
      end
    end
  end
end
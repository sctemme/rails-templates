# Basic template to set up new apps with the stuff I always do anyway.
# Templates (canonically?) documented at:
# http://guides.rubyonrails.org/generators.html#application-templates

git :init

# file ".gitignore", <<-END
# .bundle
# db/*.sqlite3
# log/*.log
# tmp/
# .sass-cache/
# .idea
# public/assets
# END

append_to_file '.gitignore', '.idea'

gem_group :development, :test do
  gem 'rspec-rails'
#  gem 'sqlite3'
end

gem_group :test do
  gem 'database_cleaner'
#   gem 'factory_girl'
#   gem 'spork'
#   gem 'launchy'
  gem 'cucumber-rails'
end

# gem_group :staging, :production do
#   gem 'pg'
# end

insert_into_file 'config/application.rb', :after => "Rails::Application\n" do <<-END

    # Prevent the scaffold generator from creating RSpec files for views
    # and helpers.
    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.request_specs false
    end

END
end

run "bundle install"

generate "rspec:install"
generate "cucumber:install"

git :add => "."
git :commit => "-m 'initial commit'"

require 'rubygems'
require 'rake'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "exception_logger"
    gem.summary = "Exception Logger for Rails 3"
    gem.description = "Logs exceptions inside a database table. Now available as gem for Rails3 (previously a plugin for Rails2)"
    gem.email = "roland.guem@gmail.com"
    gem.homepage = "http://github.com/QuBiT/exception_logger"
    gem.authors = ["Roland Guem"]
    gem.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*", "{public}/**/*"]
    gem.test_files = Dir["{test}/**/*"]
    gem.add_dependency 'rails', '>=3.0.0'
    gem.add_dependency "kaminari"
    gem.add_dependency "squeel"
    gem.add_dependency "i18n", ">= 0.4.1"
    gem.add_development_dependency "shoulda", ">= 2.11.3"
    gem.extra_rdoc_files = ["LICENSE","README.rdoc"]
    gem.post_install_message = %q{
_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_
    Thank you for installing exception_logger.
    Please be sure to read the README and HISTORY on
        http://github.com/QuBiT/exception_logger
    for important information about this release. Happy logging!
_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_()_
    }
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

ENV['BUNDLE_GEMFILE'] = File.dirname(__FILE__) + '/test/rails_root/Gemfile'

#require 'rake'
require 'rake/testtask'
require 'cucumber/rake/task'
require 'spec/rake/spectask'

namespace :test do
  Rake::TestTask.new(:basic => %w(test:generator:rails_setup test:generator:exception_migration)) do |task|
    task.libs << "lib"
    task.libs << "test"
    task.pattern = "test/**/*_test.rb"
    #task.verbose = false
  end

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format progress"
    t.profile = 'features'
  end

  namespace :generator do

    task :rails_setup do
      system "cd test && rails new rails_root --skip"
    end

    task :exception_migration do
      system "cd test/rails_root && bundle install && ./script/rails generate exception_logger:migration && rake db:migrate db:test:prepare"
    end
  end

end

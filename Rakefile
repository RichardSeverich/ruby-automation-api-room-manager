# Author: Daniel Cabero
require 'bundler/gem_tasks'
require 'rubygems'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec'

# Task default for the run in the travis CI.
task :spec do
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
  Rake::Task[:spec].invoke

end

# Task for the generate the report of the all features files.
task :@all do
  Cucumber::Rake::Task.new :all do |t|
    t.profile = 'default'
    sh 'cucumber --format PrettyFace::Formatter::Html --out test_reports/all.html'
  end
end

# Task for the generate the report of the smoke features files.
task(:@smoke) {
  Cucumber::Rake::Task.new :smoke do |t|
    t.profile = 'default'
    sh 'cucumber --tags @smoke --format PrettyFace::Formatter::Html --out test_reports/smoke.html'
  end
}

# Task for the generate the report of the CRUD features files.
task :@crud do
  Cucumber::Rake::Task.new :crud do |t|
    t.profile = 'default'
    sh 'cucumber --tags @crud --format PrettyFace::Formatter::Html --out test_reports/crud.html'
  end
end

# Task for the generate the report of the Functional features files.
task :@functional do
  Cucumber::Rake::Task.new :functional do |t|
    t.profile = 'default'
    sh 'cucumber --tags @functional --format PrettyFace::Formatter::Html --out test_reports/functional.html'
  end
end

task :@positive do
  Cucumber::Rake::Task.new :positive do |t|
    t.profile = 'default'
    sh 'cucumber --tags @positive --format PrettyFace::Formatter::Html --out test_reports/positive.html'
  end
end

task :@negative do
  Cucumber::Rake::Task.new :negative do |t|
    t.profile = 'default'
    sh 'cucumber --tags @negative --format PrettyFace::Formatter::Html --out test_reports/negative.html'
  end
end
task :@rm do
  Cucumber::Rake::Task.new :rm do |t|
    t.profile = 'default'
    sh 'cucumber --tags @rm --format PrettyFace::Formatter::Html --out test_reports/rm.html'
  end
end

task :@rooms do
  Cucumber::Rake::Task.new :rooms do |t|
    t.profile = 'default'
    sh 'cucumber --tags @rooms --format PrettyFace::Formatter::Html --out test_reports/rooms.html'
  end
end

task :@services do
  Cucumber::Rake::Task.new :services do |t|
    t.profile = 'default'
    sh 'cucumber --tags @services --format PrettyFace::Formatter::Html --out test_reports/services.html'
  end
end

task :@meetings do
  Cucumber::Rake::Task.new :meetings do |t|
    t.profile = 'default'
    sh 'cucumber --tags @meetings --format PrettyFace::Formatter::Html --out test_reports/meetings.html'
  end
end

task :@issue do
  Cucumber::Rake::Task.new :issue do |t|
    t.profile = 'default'
    sh 'cucumber --tags @issue --format PrettyFace::Formatter::Html --out test_reports/issue.html'
  end
end

# the execute default for the clean.
task(:default).clear

#
task default: :spec

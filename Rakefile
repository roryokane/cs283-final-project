require 'rake'

task :default => :test

desc "Run all working tests in the test suite"
task :test => [ :converting_test ]

desc "Run the integrated conversion tests"
task :converting_test do 
  sh %Q{bundle exec ruby test/converting_test.rb}
end

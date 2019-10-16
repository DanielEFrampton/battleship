require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

desc "A rake welcome message"
task :complete do
  puts "***** Rake tasks complete. ******"
end

task default: ["test", "complete"]

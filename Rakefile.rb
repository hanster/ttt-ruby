require 'rspec/core/rake_task'

task :default => [:spec]

task :spec do
  desc "Run all the specs."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
end

task :integration do
  desc "Run the integration specs."
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/integration/**/*_spec.rb"
  end
end

task :unit do
  desc "Run the unit test specs."
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "spec/tictactoe/**/*_spec.rb"
  end
end

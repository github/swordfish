namespace :spec do
  desc 'Run all Jasmine specs'
  task :javascripts do
    require 'webmock'
    WebMock.disable_net_connect!(:allow_localhost => true)
    require 'guard/jasmine/cli'
    Guard::Jasmine::CLI.start([])
  end
end

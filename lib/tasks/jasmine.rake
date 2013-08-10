if %(development test).include? ENV['RACK_ENV']
  require 'guard/jasmine/task'
  Guard::JasmineTask.new
end

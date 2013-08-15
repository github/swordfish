begin
  require 'guard/jasmine/task'
  Guard::JasmineTask.new
rescue LoadError
end
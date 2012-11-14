@fixture = (name) ->
  Evergreen.templates[name]

beforeEach ->
  localStorage.clear()

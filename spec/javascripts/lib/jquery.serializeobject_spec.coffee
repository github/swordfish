require '/assets/lib/jquery.js'
require '/assets/lib/jquery.serializeobject.js'

describe 'jQuery.fn.serializeObject', ->
  it 'returns object for form inputs', ->
    @form = $('''
      <form>
        <input type="text" name="name" value="Brandon">
        <textarea name="bio">maker</textarea>
      </form>
    ''')

    result = {name: 'Brandon', bio:'maker'}
    expect(@form.serializeObject()).toEqual(result)
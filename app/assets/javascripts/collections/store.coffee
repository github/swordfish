encrypt = (obj) ->
  data      = JSON.stringify obj
  key       = CryptoJS.SHA1(data).toString()
  encrypted = CryptoJS.AES.encrypt(data, key).toString()
  {key, encrypted}

decrypt = (data, key) ->
  decrypted = CryptoJS.AES.decrypt(data, key)
  JSON.parse decrypted.toString(CryptoJS.enc.Utf8)

@Store =
  put: (obj, callback) ->
    {key, encrypted} = encrypt obj
    $.ajax
      type: 'POST'
      url: "/objects"
      data: { data: encrypted }
      success: (resp) ->
        localStorage.setItem resp.id, resp.data
        callback? null, {key: key, id: resp.id, data: obj}
      error: (err) ->
        callback? err
    return

  get: (id, key, callback) ->
    if data = localStorage.getItem id
      obj = decrypt data, key
      callback? null, {key: key, id: id, data: obj}
    else
      $.ajax
        type: 'GET'
        url: "/objects/#{id}"
        success: (resp) ->
          obj = decrypt resp.data, key
          callback? null, {key: key, id: id, data: obj}
        error: (err) ->
          callback? err
      return

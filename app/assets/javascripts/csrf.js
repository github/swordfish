$.ajaxPrefilter(function(options, originalOptions, xhr){
  if ( !options.crossDomain ) {
    var token = $('meta[name="csrf-token"]').attr('content');
    if (token) xhr.setRequestHeader('X-CSRF-Token', token);
  }
});

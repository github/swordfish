(function($) {
  $.fn.serializeObject = function() {
    var result = {}
    $.each(this.serializeArray(), function() {
      result[this.name] = this.value;
    });
    return result;
  };
})(jQuery);


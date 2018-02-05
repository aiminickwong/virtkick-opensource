define(function(require) {
  var $ = require('jquery');

  return function(progressId, onSuccess, onError) {
    var id = setInterval(function() {
      return $.ajax('/progress/' + progressId).success(function(data) {
        if (!data.finished) {
          return;
        }
        clearInterval(id);

        data.error === null ? onSuccess() : onError(data.error);
      });
    }, 500);
  };
});
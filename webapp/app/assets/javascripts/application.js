
define('application', function(require) {
  var $ = require('jquery');
  require('jquery_ujs');
  require('jquery.ajaxchimp')
  require('bootstrap');
  require('twitter/bootstrap/rails/confirm');
  require('!domReady');
  var ga = require('snippets/analytics');


  $('.newsletter form').ajaxChimp({
    callback: function(response, element) {
      resultElement = $('.newsletter .result');

      if (response.result == 'error') {
        if (response.msg.indexOf('is already subscribed') != -1) {
          resultElement.text("Nothing to do. You're already subscribed!");
        } else {
          resultElement.text(response.msg);
        }
      } else {
        resultElement.text(resultElement.data('success'));
        ga('send', 'event', 'newsletter_alpha', 'subscribe');
      }
    }
  });
});
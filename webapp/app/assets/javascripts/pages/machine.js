define(function(require) {
  var $ = require('jquery');

  var handleProgress = require('./handleProgress');

  // ISO image change (Console & Settings Tabs)

  $('.iso_dropdown').change(function() {
    var form = $(this).closest('form');
    form.submit();
    var spinner = form.find('.fa-spinner');
    spinner.removeClass('hidden');
    form.on('ajax:success', function(e, data) {
      handleProgress(data.progress_id, function() {
        spinner.addClass('hidden');

        var tick = form.find('.fa-check');
        tick.removeClass('hidden');
        setTimeout(function() {
          tick.fadeOut('slow', function() {
            tick.addClass('hidden');
            tick.show();
          });
        }, 500);

      }, function(error) {
        spinner.addClass('hidden');
        form.find('fa-warning').removeClass('hidden');
      })
    })
  });

  // Power Tab

  var actions = {
    'start': ['Starting', 'icon fa fa-spinner fa-spin'],
    'pause': ['Paused', 'icon fa fa-pause'],
    'resume': ['Running', 'icon fa fa-play'],
    'stop': ['Stopping', 'icon fa fa-spinner fa-spin'],
    'restart': ['Restart requested', 'icon fa fa-play'],
    'hard-stop': ['Hard stopping', 'icon fa fa-spinner fa-spin'],
    'hard-reset': ['Resetting', 'icon fa fa-spinner fa-spin']
  };

  var $powerState = $('.power-state');

  var reloadButtonState = function() {
    var state = $powerState.text().trim();
    if (state === 'Running') {
      $('.only-on').removeClass('disabled');
      $('.start, .resume').addClass('disabled');
    } else if (state == 'Paused') {
      $('.only-on, .start').addClass('disabled');
      $('.start').addClass('disabled');
      $('.resume').removeClass('disabled');
    } else {
      $('.only-on').addClass('disabled');
      $('.start').removeClass('disabled');
    }
  };

  reloadButtonState();

  $('.controls a.action').click(function () {
    var $this = $(this);
    var action = $this.text().toLowerCase().trim();
    var actionUrl = $this.attr('href');

    var tempState = actions[action][0];
    var tempClasses = actions[action][1];

    var $powerState = $('.power-state');
    var $icon = $powerState.find('.icon');
    var $status = $powerState.find('.status');

    $icon.attr('class', tempClasses);
    $status.text(tempState);

    reloadButtonState();

    var handleProgress = require('pages/handleProgress');

    var getCurrentState = function() {
      $.ajax(window.location.pathname + '/state').success(function(data) {
        $icon.attr('class', 'icon ' + data.icon);
        $status.text(data.name);
        $powerState.data('running', data.running);
        reloadButtonState();
      });
    };

    $.post(actionUrl).success(function(data) {
      handleProgress(data.progress_id, function() {
        getCurrentState();
      }, function(error) {
        var alert = '<div class="alert alert-danger fade in">' +
          '<button class="close" data-dismiss="alert">×</button>' +
          error +
          '</div>';
        $('.controls').prepend($(alert));
        getCurrentState();
      });
    });

    return false;
  });

  // Storage Tab

  $('#page-storage .create-button').click(function() {
    $('#page-storage .create-button').fadeOut(200, function () {
      $('#page-storage .new').fadeIn(200);
    });
  });

  $('#page-storage .save-button').click(function() {
    $('#page-storage .new').fadeOut(200, function () {
      $('#page-storage .create-button').fadeIn(200);
    });
  });

  $('#new_disk').submit(function() {
    var form = $(this);
    var example = $('.example');
    var row = example.clone();
    row.removeClass('example hidden');
    row.find('.name .name').text(form.find('.name').text());
    row.find('.type').text(form.find('.type select :selected').text());
    row.find('.size').text(form.find('.size select :selected').text() + ' GB');
    example.closest('table').prepend(row);

    $.post(form.attr('action'), form.serializeArray()).success(function(data) {
      handleProgress(data.progress_id, function() {
        row.find('.name .fa-spinner').remove();
        var tick = row.find('.name .fa-check');
        tick.removeClass('hidden');
        setTimeout(function() {
          tick.fadeOut('slow');
        }, 500);
      }, function (error) {
        row.find('.name .fa-spinner').remove();
        row.find('.name .error').removeClass('hidden');
        row.find('.name .message').text(error);
      });
    });

    return false;
  });

  $('a.delete-disk').on('ajax:success', function(e, data) {
    console.log(e.currentTarget);
    var link = $(e.currentTarget);
    var row = link.closest('tr');
    row.find('.name .fa-spinner').removeClass('hidden');

    handleProgress(data.progress_id, function() {
      row.fadeOut('slow');
      setTimeout(function () {
        row.remove();
      }, 1000);
    }, function (error) {
      row.find('.name .fa-spinner').addClass('hidden');
      row.find('.name .error').removeClass('hidden');
      row.find('.name .message').text(error);
    });
  });
});

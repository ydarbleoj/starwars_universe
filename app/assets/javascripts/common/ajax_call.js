var apiListCall = function(obj, path) {
  var url = (path) ? path : '/' + obj
  Rails.ajax({
    url: 'http://localhost:3000/api/v1' + url + '/',
    type: 'GET',
    dataType: 'json',
    success: function (res) {
      updateDisplayPage(res, obj)
    },
    error: function (res) {
      console.log('error', res)
    }
  });
}

var ajaxShow = function (url) {
  Rails.ajax({
    url: 'http://localhost:3000/api/v1' + url,
    type: 'GET',
    dataType: 'json',
    success: function (res) {
      console.log('res', res)
      displayPage([res])
    },
    error: function (res) {
      console.log('error', res)
    }
  })
}

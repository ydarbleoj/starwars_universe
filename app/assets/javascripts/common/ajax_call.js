var apiListCall = function(obj, path) {
  var url = (path) ? path : '/' + obj
  Rails.ajax({
    dataType: 'html',
    url: 'http://localhost:3000/api/v1' + url + '/',
    type: 'GET',
    success: function (res) {
      console.log('res', res)
      updateDisplayPage(res, obj)
    },
    error: function (res) {
      console.log('error', res)
    }
  });
}


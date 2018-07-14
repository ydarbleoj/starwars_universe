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
      updateDisplayPage(res, obj)
    }
  });
}

var ajaxShow = function (url) {
  Rails.ajax({
    url: 'http://localhost:3000/api/v1' + url,
    type: 'GET',
    dataType: 'json',
    success: function (res) {
      console.log('kurl', url)
      updatePageNav(url)
      displayPage([res])
    },
    error: function (res) {
      displayPage([res])
    }
  })
}

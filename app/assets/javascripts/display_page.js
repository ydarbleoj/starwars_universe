var displayPageNav = function (res, obj) {
  var el = document.getElementsByClassName('display-nav')[0];
  var page = pageNumber(res);

  while (el.firstChild) {
    el.removeChild(el.firstChild)
  }

  el.insertAdjacentHTML('beforeend', '<div id="prev">Prev</div>');
  el.insertAdjacentHTML('beforeend', '<div>Page ' + page + '</div>');
  el.insertAdjacentHTML('beforeend', '<div id="next">Next</div>');

  navButton(res['previous'], 'prev', obj)
  navButton(res['next'], 'next', obj)
}

var navButton = function (url, id, obj) {
  var el = document.getElementById(id);
  if (url) {
    el.addEventListener("click", function (event) {
      event.preventDefault();

      var data = cleanUrl(url)
      apiListCall(obj, data)
    })
  } else {
    el.classList.add('inactive')
  }
}

var updateDisplayPage = function (res, obj) {
  displayPageNav(res, obj)
  displayPage(res['results'])
}

var displayPage = function (res) {
  console.log('display', res)
  var el = document.getElementsByClassName('container')[0];

  while (el.firstChild) {
    el.removeChild(el.firstChild)
  }

  res.forEach(function (item) {
    var str = JSON.stringify(item, null, 4)
    el.insertAdjacentHTML('beforeend', '<div id="main-display"><pre>' + str + '</pre></div>')
  })

}

var cleanUrl = function (url) {
  return url.split('/api')[1];
}

var pageNumber = function (res) {
  if (res['next']) {
    return res['next'].split('?page=')[1] - 1;
  } else if (res['previous']) {
    return parseInt(res['previous'].split('?page=')[1]) + 1;
  } else {
    return 1
  }
}


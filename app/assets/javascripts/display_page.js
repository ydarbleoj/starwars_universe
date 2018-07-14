var updateDisplayPage = function (res, obj) {
  displayPageNav(res, obj)
  displayPage(res['results'])
}

var displayPageNav = function (res, obj) {
  var el = document.getElementsByClassName('display-nav')[0];
  var page = pageNumber(res);

  removeElements(el)

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
var updatePageNav = function (url) {
  var id = url.split('/')[1];
  var newActive = document.getElementById(id);
  var curActive = document.getElementsByClassName('active')[0];
  var pageNav = document.getElementsByClassName('display-nav')[0]

  removeElements(pageNav)
  curActive.className = ''
  newActive.className += 'active'
}

var displayPage = function (res) {
  var ids = [];
  var el = document.getElementsByClassName('container')[0];
  removeElements(el)

  res.forEach(function (item) {
    var str = JSON.stringify(item, null, 4)
    parsingJson(str, el, ids)
  });
  urlButton(ids)
}

var n = 0;
var parsingJson = function (obj, el, ids) {
  str = obj.replace(/((?=").*)|((.*?)\],)+/g, function (o) {
    var regTag = function () {
      return '<div style="text-indent:40px;height:20px">' + o + '</div>';
    }

    var btnTag = function (i) {
      n += 1;
      var id = 'btn' + n;

      ids.push(id)
      return '<div id="btn'+ n +'" style="text-indent:' + i + 'px;height:20px;">' + o + '</div>';
    }

    rtnStr = 0;
    if (o.includes(']')) {
      rtnStr = regTag();
    } else if (o.includes('https') || o.includes('url')) {
      var ii = 40;
      if (o.match(/:/g).length === 1) {
        ii += 40
      }

      rtnStr = btnTag(ii);
    } else {
      rtnStr = regTag();
    }
    return rtnStr;
  });
  el.insertAdjacentHTML('beforeend', '<div id="main-display">' + str + '</div>')
}

var urlButton = function (ids) {
  ids.forEach(function (id) {
    var el = document.getElementById(id);
    el.addEventListener("click", function (event) {
      event.preventDefault();
      var url = cleanUrl(this.textContent).replace(/['",]+/g, '');

      ajaxShow(url)
    })
  })
}

var removeElements = function (el) {
  while (el.firstChild) {
    el.removeChild(el.firstChild)
  }
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


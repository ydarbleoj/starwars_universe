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

var displayPage = function (res) {
  var el = document.getElementsByClassName('container')[0];
  removeElements(el)

  res.forEach(function (item) {
    var str = JSON.stringify(item, null, 4)
    addButtonsToJson(str, el)
  });
}

var addButtonsToJson = function (obj, el) {
  var i = {
    indent: 0
  };
  console.log('add buttons ', obj)
  str = obj.replace(/((?=").*)|([],])/g, function (o) {
    var rtnFn = function () {
      return '<div style="text-indent:40px;height:20px">' + o + '</div>';
    }

    var rtnBtn = function (i) {
      return '<div class="btn" style="text-indent:' + i + 'px;height:20px;">' + o + '</div>';
    }

    rtnStr = 0;
    if (o.includes(']')) {
      rtnStr = rtnFn();
    } else if (o.includes('https') || o.includes('url')) {
      var ii = 40;
      if (o.match(/:/g).length === 1) {
        ii += 40
      }
      rtnStr = rtnBtn(ii);
    } else {
      i['indent'] += 1;
      rtnStr = rtnFn();
    }
    return rtnStr;
  });
  el.insertAdjacentHTML('beforeend', '<div id="main-display">' + str + '</div>')
  urlButton()
}

var urlButton = function () {
  document.querySelectorAll(".btn").forEach(function (item) {
    item.addEventListener("click", function (event) {
      event.preventDefault();

      var url = cleanUrl(this.textContent).replace(/['",]+/g, '')
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


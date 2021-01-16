var colunmSize = 4;

if ($(window).width() < 1200) {
  colunmSize = 4;
}
if ($(window).width() < 992) {
  colunmSize = 4;
}
if ($(window).width() < 768) {
  colunmSize = 4;
  $('li .d-none').removeClass('d-none');
}
if ($(window).width() < 576) {
  colunmSize = 6;
}
if ($(window).width() < 360) {
  colunmSize = 12;
}
if ($(window).width() >= 768 && $(window).width() <= 1024) {
  $('ul').removeClass('flex-column');
}
$('.menu-hidden .menu').on('click', function () {
  $('.article').toggle();
  $('.my-nav').toggle();
});

$('.menu-hidden .search').on('click', function () {
  $('.title h1').toggle();
  $('#movil_search').toggle();
});

function getJSON(url) {
  var request = new XMLHttpRequest();
  request.open("GET", url, false);
  request.send(null);
  return request.status == 200 ? JSON.parse(request.responseText) : ''
}

function updateImagesDestacadas() {
  var datos = getJSON('http://localhost:3000/destacados');
  $.each(datos.data, function(i, background) {
    var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
    '<a href="/backgrounds/' + background['id'] + '">' +
    '<img id="' + background['id'] + '" src="' + background['path'] + '"alt="' + background['title'] + '"></a></div>';
    $('.rellenarDestacadas').append(img);
  })
}

function updateImagesRecientes() {
  var datos = getJSON('http://localhost:3000/recientes');
  $.each(datos.data, function(i, background) {
    var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
      '<a href="/backgrounds/' + background['id'] + '">' +
      '<img id="' + background['id'] + '" src="' + background['path'] + '" alt="' + background['title'] + '"></a></div>';
    $('.rellenarRecientes').append(img);
  })
}

function updateAllImagesRecientes() {
  var datos = getJSON('http://localhost:3000/allRecientes');
  var arrCategory = [];
  $.each(datos.data, function (i, background) {
      arrCategory.push(background);
  });
  $('#pagination').pagination({
    dataSource: arrCategory,
    pageSize: 6,
    callback: function (data, pagination) {
      $('.rellenarCategorias').empty();
      $.each(data, function (i, element) {
        var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
            '<a href="/backgrounds/' + element['id'] + '">'  +
            '<img id="' + element['id'] + '" src="' + element['path'] + '" alt="' + element['title'] + '"></a></div>';
          $('.rellenarCategorias').append(img);
      });
    }
  });
}

function updateAllImagesDestacados() {
  var datos = getJSON('http://localhost:3000/allDestacados');
  var arrCategory = [];
  $.each(datos.data, function (i, background) {
      arrCategory.push(background);
  });
  $('#pagination').pagination({
    dataSource: arrCategory,
    pageSize: 6,
    callback: function (data, pagination) {
      $('.rellenarCategorias').empty();
      $.each(data, function (i, element) {
        var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
            '<a href="/backgrounds/' + element['id'] + '">'  +
            '<img id="' + element['id'] + '" src="' + element['path'] + '" alt="' + element['title'] + '"></a></div>';
          $('.rellenarCategorias').append(img);
      });
    }
  });
}

function updateImagesCategories(category) {
  var arrCategory = [];
  $.each(JSON.parse(category), function (i, background) {
      arrCategory.push(background);
  });
  $('#pagination').pagination({
    dataSource: arrCategory,
    pageSize: 6,
    callback: function (data, pagination) {
      $('.rellenarCategorias').empty();
      $.each(data, function (i, element) {
        //console.log(element, 'asd')
          var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
            '<a href="/backgrounds/' + element['id'] + '">'  +
            '<img id="' + element['id'] + '" src="' + element['path'] + '" alt="' + element['title'] + '"></a></div>';
          $('.rellenarCategorias').append(img);
      });
    }
  });
}

function updateImagesSearch(category){
  var arrCategory = [];
  $.each(JSON.parse(category), function (background) {
      arrCategory.push(background);
  });
  $('#pagination').pagination({
    dataSource: arrCategory,
    pageSize: 6,
    callback: function (data, pagination) {
      $('.rellenarCategorias').empty();
      $.each(data, function (i, element) {
        //console.log(element, 'asd')
          var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
            '<a href="/backgrounds/' + element['id'] + '">'  +
            '<img id="' + element['id'] + '" src="' + element['path'] + '" alt="' + element['title'] + '"></a></div>';
          $('.rellenarCategorias').append(img);
      });
    }
  });
}

function updateFondosPerfil(category, div, pag) {
  var arrCategory = [];
  $.each(JSON.parse(category), function (i, background) {
      arrCategory.push(background);
  });
  $(pag).pagination({
    dataSource: arrCategory,
    pageSize: 6,
    callback: function (data, pagination) {
      $(div).empty();
      $.each(data, function (i, element) {
        //console.log(element, 'asd')
          var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
            '<a href="/backgrounds/' + element['id'] + '">'  +
            '<img id="' + element['id'] + '" src="' + element['path'] + '" alt="' + element['title'] + '"></a></div>';
          $(div).append(img);
      });
    }
  });
}

function validarDatos() {
  var nombre = $("#nombre").val();
  var correo = $("#correo").val();
  var contra = $('#contraseña').val();
  var contra2 = $('#contraseña2').val();
  $('span').text('');

  if (nombre.length <= 5 || nombre.length > 20) {
    $("#span_nombre").text('El nombre debe tener entre 4 y 20 caracteres');
    return false;
  }

  if (correo.length <= 6 || correo.length > 32) {
    $('#span_correo').text("El eamil debe tener de 6 a 32 caracteres");
    return false;
  }
  if (contra.length <= 6) {
    $("#span_contra").text("La contraseña debe tener más de 8 caracteres");
    return false;
  }
  if (contra2.length <= 6) {
    $("#span_contra2").text("La contraseña debe tener más de 8 caracteres");
    return false;
  }
  if (contra != contra2) {
    $("#span_contra2").text("Las contraseñas son distintas");
    return false;
  }
  return true;
}


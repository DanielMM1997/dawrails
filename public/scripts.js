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

function getCategory(category) {
  var datos = getJSON('content/backgrounds.json');
  var onylThisCategory = [];
  $.each(datos.backgrounds, function (i, element) {
    for (let field = 0; field < element.length; field++) {
      if (element[field].categories == category) {
        onylThisCategory.push(element);
      }
    }
  });
  return onylThisCategory;
}

function getImage(id) {
  var datos = getJSON('content/backgrounds.json');
  var imagen;
    $.each(datos.backgrounds, function (i, element) {
    for (let field = 0; field < element.length; field++) {
      if (element[field].id == id) {
        imagen = element[field];
      }
    }
  });
  return imagen;
}

function updateImagesDestacadas() {
  var datos = getJSON('content/backgrounds.json');
  for (let i = 0; i < 6; i++) {
    for (var j in datos['backgrounds'][i]) {
      var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
        '<a href="view_image.php?id=' + datos['backgrounds'][i][j]['id'] + '&category=' + datos['backgrounds'][i][j]['categories'] + '">' +
        '<img id="' + datos['backgrounds'][i][j]['id'] + '" src="' + datos['backgrounds'][i][j]['url'] + '" alt="' + datos['backgrounds'][i][j]['title'] + '"></a></div>';
      $('.rellenarDestacadas').append(img);
    }
  }
}

function updateImagesRecientes() {
  var datos = getJSON('content/backgrounds.json');
  for (let i = 6; i < 12; i++) {
    for (var j in datos['backgrounds'][i]) {
      var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
        '<a href="view_image.php?id=' + datos['backgrounds'][i][j]['id'] + '&category=' + datos['backgrounds'][i][j]['categories'] + '">' +
        '<img id="' + datos['backgrounds'][i][j]['id'] + '" src="' + datos['backgrounds'][i][j]['url'] + '" alt="' + datos['backgrounds'][i][j]['title'] + '"></a></div>';
      $('.rellenarRecientes').append(img);
    }
  }
}

function updateImagesCategories(category) {
  var thisCategory = getCategory(category);
  $('#pagination').pagination({
    dataSource: thisCategory,
    pageSize: 6,
    callback: function (data, pagination) {
      $('.rellenarCategorias').empty();
      $.each(data, function (i, element) {
        for (let field = 0; field < element.length; field++) {
          var img = '<div class="col-' + colunmSize + ' responsive p-1">' +
            '<a href="view_image.php?id=' + element[field].id + '&category=' + element[field].categories + '">' +
            '<img id="' + element[field].id + '" src="' + element[field].url + '" alt="' + element[field].title + '"></a></div>';
          $('.rellenarCategorias').append(img);
        }
      });
    }
  });
}


function updateImage(id) {
  var ele = getImage(id);
  var img = '<div class="col-12 responsive p-3">' +
    '<img id="' + ele['id'] + '" src="' + ele['url'] + '" alt="' + ele['title'] + '"></div>';
  $('.rellenarImagen').append(img);
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
  if (contra.length <= 8) {
    $("#span_contra").text("La contraseña debe tener más de 8 caracteres");
    return false;
  }
  if (contra2.length <= 8) {
    $("#span_contra2").text("La contraseña debe tener más de 8 caracteres");
    return false;
  }
  if (contra != contra2) {
    $("#span_contra2").text("Las contraseñas son distintas");
    return false;
  }
  return true;
}


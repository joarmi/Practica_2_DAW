//Javascript

function invokeScript(divid)
{
    var scriptObj = divid.getElementsByTagName("SCRIPT");
    var len = scriptObj.length;
    for (var i = 0; i < len; i++)
    {
        var scriptText = scriptObj[i].text;
        var scriptFile = scriptObj[i].src;
        var scriptTag = document.createElement("SCRIPT");
        if ((scriptFile != null) && (scriptFile != "")) {
            scriptTag.src = scriptFile;
        }
        scriptTag.text = scriptText;
        if (!document.getElementsByTagName("HEAD")[0]) {
            document.createElement("HEAD").appendChild(scriptTag);
        } else {
            document.getElementsByTagName("HEAD")[0].appendChild(scriptTag);
        }
    }
}

function nuevaConexion()
{
    var xmlhttp = false;
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e)
    {
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E)
        {
            xmlhttp = false;
        }
    }

    if (!xmlhttp && typeof XMLHttpRequest != 'undefined')
    {
        xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
}

function Cargar(url, capa)
{
    var contenido = document.getElementById(capa);
    var conexion = nuevaConexion();
    conexion.open("GET", url, true);
    conexion.onreadystatechange = function ()
    {
        if (conexion.readyState == 4)
        {
            contenido.innerHTML = conexion.responseText;
            invokeScript(document.getElementById(capa));
        }
    }
    conexion.send(null);
}

function CargarForm(url, capa, valores)
{
    var contenido = document.getElementById(capa);
    var conexion = nuevaConexion();
    conexion.open("POST", url, true);
    conexion.onreadystatechange = function ()
    {
        if (conexion.readyState == 4)
        {
            contenido.innerHTML = conexion.responseText;
            invokeScript(document.getElementById(capa));
        }
    };
    conexion.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    conexion.send(valores);
}

function ProcesarForm(formulario, url, capa)
{
    var valores = "";
    for (i = 0; i < formulario.elements.length; i++)
    {
        var nombre = formulario.elements[i].name;
        if (nombre != "")
        {
            if (!((formulario.elements[i].type == "radio") && (!formulario.elements[i].checked)))
            {
                valores += formulario.elements[i].name + "=";
                valores += formulario.elements[i].value + "&";
            }
        }
    }
    CargarForm(url, capa, valores);
}

function cargaInicial()
{
    Cargar('menu.html', 'menu');
    Cargar('inicial.html', 'capa1');
}

/*------------------------------------------------------------*/

function initMap() {
    var uluru = {lat: 40.410600, lng: -3.676707};
    var map = new google.maps.Map(document.getElementById('map'), {zoom: 17, center: uluru});
    var marker = new google.maps.Marker({position: uluru, map: map});
}

function habilitar(){
    document.getElementById("nombre").disabled = false;
    document.getElementById("apellidos").disabled = false;
    document.getElementById("user").disabled = false;
    document.getElementById("pwd").disabled = false;
    document.getElementById("tel").disabled = false;
    document.getElementById("dir").disabled = false;
    document.getElementById("mail").disabled = false;
    document.getElementById("boton").disabled = false;
}

function deshabilitar(){
    document.getElementById("nombre").disabled = true;
    document.getElementById("apellidos").disabled = true;
    document.getElementById("user").disabled = true;
    document.getElementById("pwd").disabled = true;
    document.getElementById("tel").disabled = true;
    document.getElementById("dir").disabled = true;
    document.getElementById("mail").disabled = true;
    document.getElementById("boton").disabled = true;
}

function realizarPedidos(){
    document.getElementById("num1").disabled = true;
    document.getElementById("num2").disabled = true;
    document.getElementById("num3").disabled = true;
    document.getElementById("mod1").disabled = true;
    document.getElementById("mod2").disabled = true;
    document.getElementById("mod3").disabled = true;
    document.getElementById("can1").disabled = true;
    document.getElementById("can2").disabled = true;
    document.getElementById("can3").disabled = true;
    
    alert("Pedidos enviados");
}
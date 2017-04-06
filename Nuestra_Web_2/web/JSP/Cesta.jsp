<%-- 
    Document   : Cesta
    Created on : 06-abr-2017, 12:25:42
    Author     : Javier Argente Micó
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="base_de_datos.accesoBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src=../JavaScript/libCapas.js></script>
        <link rel="stylesheet" href="../CSS/Cesta.css" type="text/css"/>
    </head>
    <body>
        <form action="procesar.cgi" method="POST">

            <div class="menu">
                <header id="menu">
                    <script> Cargar("../HTML/Auxiliar/Menu_desplegable.html", "menu");</script>
                </header>
            </div>

            <br> <br> <br> <br>

            <%   
                accesoBD con = new accesoBD();
                ResultSet pedidos = con.obtenerPedidosBD();
            %> 


            <div class="principal">
                <article>
                    <table border="1" id="pedidos">

                        <tr>
                            <td> <b> Nombre </b> </td> <td> <b> Unidades </b> </td> <td> <b> Precio (€) </b> </td>
                        </tr>

                        <%
                            while (pedidos.next()) {
                                int id = pedidos.getInt("id_pedido");
                                String nombre_usuario = pedidos.getString("nombre_usuario");
                                String nombre_producto = pedidos.getString("nombre_producto");
                                float precio = pedidos.getFloat("precio");
                                int cantidad = pedidos.getInt("cantidad");

                                float precio_final = precio * cantidad;
                        %> 

                        <tr>                     
                            <td> <%=nombre_producto%> </td>                     
                            <td> <input type="number" id="num1" min="1" max="999999999" value="<%=cantidad%>"/> </td>                     
                            <td> <%=precio_final%> </td>                     
                            <td> <input type="button" id="mod<%=id%>" value="Modificar"/> </td>
                            <td> <input type="button" id="can<%=id%>" value="Cancelar"/> </td>
                        </tr>
                        
                        <% 
                            }
                        %>

                    </table>
                </article>


                <br>

                <input type="button" value="Realizar pedido" id="boton"/>

            </div>

            <br> <br>

            <footer id="pie"> 
                <script> Cargar("../HTML/Auxiliar/Pie_de_pagina.html", "pie");</script>
            </footer>

        </form>
    </body>
</html>

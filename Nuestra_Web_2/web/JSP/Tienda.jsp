<%-- 
    Document   : Tienda
    Created on : 06-abr-2017, 13:05:41
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
        <link rel="stylesheet" href="../CSS/Tienda.css" type="text/css"/>
    </head>
    <body>

            <div class="menu">
                <header id="menu">
                    <script> Cargar("../HTML/Auxiliar/Menu_desplegable.html", "menu");</script>
                </header>
            </div>

            <br>
            
            <%   
                accesoBD con = new accesoBD();
                ResultSet productos = con.obtenerProductosBD();
            %> 

            <div class="principal">
                <article>
                    <table border="1" id="productos">
                        
                        <tr>
                            <td> <b> Portada </b> </td> <td> <b> Nombre </b> </td> <td> <b> Precio (€) </b> </td> <td> <b> Stock </b> </td> <td> <b> Descripción </b> </td>
                        </tr>
                        
                        <%
                            while (productos.next()) {
                                int id = productos.getInt("id_producto");
                                String nombre_producto = productos.getString("nombre_producto");
                                String descripcion = productos.getString("descripcion");
                                float precio = productos.getFloat("precio");
                                int stock = productos.getInt("stock");
                        %>
                        
                        <tr>
                            <td> <img src="../Imagenes/<%=id%>.jpg" height="200" width="175"> </td>                     
                            <td> <%=nombre_producto%> </td>                     
                            <td> <%=precio%> </td>
                            <td> <%=stock%> </td>
                            <td> <textarea rows="12" cols="25" disabled><%=descripcion%></textarea> </td>
                            <td>
                                <form method="post" action="../sesion_tienda">
                                    <input type="hidden" name="id_producto" value="<%=id%>">
                                    <input type="hidden" name="nombre_producto" value="<%=nombre_producto%>">
                                    <input type="hidden" name="precio" value="<%=precio%>">
                                    <input type="hidden" name="stock" value="<%=stock%>">
                                    <input type="hidden" id="cantidad<%=id%>" name="cantidad<%=id%>">
                                    <input type="button" value="Solicitar" onclick="hacer_pedido(<%=id%>)">
                                    <input type="submit" value="Agregar a la cesta">
                                </form>
                            </td>
                        </tr>
                        
                        <% 
                            }
                        %>
                        
                    </table>
                </article>
            </div>

            <br>

            <footer id="pie"> 
                <script> Cargar("../HTML/Auxiliar/Pie_de_pagina.html", "pie");</script>
            </footer>

    </body>
</html>

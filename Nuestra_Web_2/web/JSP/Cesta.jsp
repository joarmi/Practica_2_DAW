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
            <div class="menu">
                <header id="menu">
                    <script> Cargar("../HTML/Auxiliar/Menu_desplegable.html", "menu");</script>
                </header>
            </div>

            <br> <br> <br> <br>

            <%   
                accesoBD con = new accesoBD();
                ResultSet pedidos = con.obtenerPedidosBD((String) session.getAttribute("usuario"));
            %> 


            <div class="principal">
                <article>
                    <table border="1" id="pedidos">

                        <tr>
                            <td> <b> Nombre </b> </td> <td> <b> Precio (€) </b> </td> <td> <b> Unidades) </b> </td>
                        </tr>

                        <%
                            while (pedidos.next()) {
                                int id = pedidos.getInt("id_pedido");
                                String nombre_usuario = pedidos.getString("nombre_usuario");
                                String nombre_producto = pedidos.getString("nombre_producto");
                                float precio = pedidos.getFloat("precio");
                                int cantidad = pedidos.getInt("cantidad");
                                int envio = pedidos.getInt("envio");

                                float precio_final = precio * cantidad;
                        %> 

                        <tr>                     
                            <td> <%=nombre_producto%> </td>
                            <td> <%=precio_final%> </td>
                            
                            <%
                                if(envio == 0){
                            %>
                            
                                    <form method="post" action="../cesta_modificar">
                                        <td> <input type="number" id="cantidad<%=id%>" name="cantidad<%=id%>" min="0" max="100" value="<%=cantidad%>" /> </td>                                        
                                        <td>
                                                <input type="hidden" name="id_pedido" value="<%=id%>">
                                                <%-- <input type="hidden" id="cantidad<%=id%>" name="cantidad<%=id%>"> --%>
                                                <%-- <input type="button" value="Modificar" onclick="cesta_modificar(<%=id%>)"> --%>
                                                <input type="submit" value="Confirmar modificación">
                                        </td>
                                    </form>

                                    <td> 
                                        <form method="post" action="../cesta_cancelar">
                                            <input type="hidden" name="id_pedido" value="<%=id%>">
                                            <input type="submit" value="Cancelar"> 
                                        </form>
                                    </td>
                                    <td> 
                                        <form method="post" action="../cesta_enviar">
                                            <input type="hidden" name="id_pedido" value="<%=id%>">
                                            <input type="submit" value="Enviar"> 
                                        </form>
                                    </td>
                            
                            <%
                                }
                            %>
                            
                            <%
                                if(envio == 1){
                            %>
                            
                                    <td> <input type="number" id="cantidad<%=id%>" name="cantidad<%=id%>" min="0" max="100" value="<%=cantidad%>" disabled="true"/> </td>                                        
                                    <td colspan="3" align="center"> <b> ENVIADO </b> </td>
                            
                            <%
                                }
                            %>
                            
                        </tr>
                        
                        <% 
                            }
                        %>

                    </table>
                </article>

            </div>

            <br> <br>

            <footer id="pie"> 
                <script> Cargar("../HTML/Auxiliar/Pie_de_pagina.html", "pie");</script>
            </footer>

    </body>
</html>

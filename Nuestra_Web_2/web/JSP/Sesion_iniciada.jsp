<%-- 
    Document   : Sesion_iniciada
    Created on : 18-abr-2017, 15:29:00
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
        <link rel="stylesheet" href="../CSS/Sesion_iniciada.css" type="text/css"/>
    </head>
    <body>

            <div class="menu">
                <header id="menu">
                    <script> Cargar("../HTML/Auxiliar/Menu_desplegable.html", "menu");</script>
                </header>
            </div>

            <br> <br>

            <%
                accesoBD con = new accesoBD();
                ResultSet pedidos = con.obtenerPedidosBD((String) session.getAttribute("usuario"));
                ResultSet datos = con.obtenerDatos((String) session.getAttribute("usuario"));
            %>
            
            <script>
                <%
                    if(request.getParameter("error") != null){
                        %>
                        alert("<%= request.getParameter("error")%>");  
                    <%}%>
            </script>

            <div class="principal">

                <article>

                    <%
                        while (datos.next()) {
                            int id_usuario = datos.getInt("id_usuario");
                            String usuario = datos.getString("usuario");
                            String contrasenya = datos.getString("contrasenya");
                            String nombre = datos.getString("nombre");
                            String apellidos = datos.getString("apellidos");
                            String telefono = datos.getString("telefono");
                            String direccion = datos.getString("direccion");
                            String email = datos.getString("email");
                    %>

                    <form method="post" action="../modificar_datos">
                        <table>
                            <tr>
                                <td> Nombre: </td> <td> <input type="text" name="nombre" id="nombre" pattern="([ ]|[a-zA-z])*" name="nombre" size="20" maxlength="20" value="<%=nombre%>" required /> </td>
                            </tr>
                            <tr>
                                <td> Apellidos: </td> <td> <input type="text" name="apellidos" id="apellidos" pattern="([ ]|[a-zA-z])*" name="apellidos" size="20" maxlength="20" value="<%=apellidos%>" required /> </td>
                            </tr>
                            <tr>
                                <td> Usuario: </td> <td> <input type="text" name="user" id="user" pattern="([_]|[a-zA-z]|[0-9])*" name="usuario" size="20" maxlength="20" value="<%=usuario%>" required /> </td>
                            </tr>
                            <tr>
                                <td> Contraseña: </td> <td> <input type="text" name="pwd" id="pwd" name="password" size="20" maxlength="20" value="<%=contrasenya%>" required/> </td>
                            </tr>
                            <tr>
                                <td> Teléfono: </td> <td> <input type="number" name="tel" id="tel" name="telefono" min="1" max="999999999" value="<%=telefono%>" required/> </td>
                            </tr>
                            <tr>
                                <td> Dirección </td> <td> <input type="text" name="dir" id="dir" name="direccion" size="40" maxlength="50" value="<%=direccion%>" required/> </td>
                            </tr>
                            <tr>
                                <td> Email </td> <td> <input type="email" name="mail" id="mail" name="email" size="40" maxlength="50" value="<%=email%>" required/> </td>
                              
                                <input type="hidden" name="id_usuario" id="id_usuario" value="<%=id_usuario%>">
                                
                                <input type="hidden" name="nombre_ori" id="nombre_ori" value="<%=nombre%>">
                                <input type="hidden" name="apellidos_ori" id="apellidos_ori" value="<%=apellidos%>">
                                <input type="hidden" name="user_ori" id="user_ori" value="<%=usuario%>">
                                <input type="hidden" name="pwd_ori" id="pwd_ori" value="<%=contrasenya%>">
                                <input type="hidden" name="tel_ori" id="tel_ori" value="<%=telefono%>">
                                <input type="hidden" name="dir_ori" id="dir_ori" value="<%=direccion%>">
                                <input type="hidden" name="mail_ori" id="mail_ori" value="<%=email%>">
                            
                            </tr>
                            <tr>
                                <td></td>
                                <td> <input type="submit" id="boton" value="Confirmar cambios" /> </td>
                            </tr>
                        </table>
                    </form>
                    
                    <%
                        }
                    %>

                    <br> <br>

                    <table border="1" id="pedidos">
                        <tr>
                            <td> <b> Nombre </b> </td> <td> <b> Precio (€) </b> </td> <td> <b> Unidades </b> </td>
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
                            
                                <form method="post" action="../producto_modificar">
                                    <td> <input type="number" id="cantidad<%=id%>" name="cantidad<%=id%>" min="0" max="100" value="<%=cantidad%>" /> </td>
                                    <td>
                                            <input type="hidden" name="id_pedido" value="<%=id%>">
                                            <%-- <input type="hidden" id="cantidad<%=id%>" name="cantidad<%=id%>"> --%>
                                            <%-- <input type="button" value="Modificar" onclick="cesta_modificar(<%=id%>)"> --%>
                                            <input type="submit" value="Confirmar modificación">
                                    </td>
                                </form>

                                <td> 
                                    <form method="post" action="../producto_cancelar">
                                        <input type="hidden" name="id_pedido" value="<%=id%>">
                                        <input type="submit" value="Cancelar"> 
                                    </form>
                                </td>
                            
                            <%
                                }
                            %>
                            
                            <%
                                if(envio == 1){
                            %>
                            
                                <td> <input type="number" id="cantidad<%=id%>" name="cantidad<%=id%>" min="0" max="100" value="<%=cantidad%>" disabled="true"/> </td>
                                <td colspan="2" align="center"> <b> ENVIADO </b>  </td>
                            
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

            <br>

            <footer id="pie"> 
                <script> Cargar("../HTML/Auxiliar/Pie_de_pagina.html", "pie");</script>
            </footer>
    </body>
</html>

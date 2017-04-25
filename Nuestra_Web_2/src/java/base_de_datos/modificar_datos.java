/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package base_de_datos;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Javier Argente Micó
 */
public class modificar_datos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            // Modificamos los datos del usuario siempre que el nuevo nombre de usuario 
            // no este siendo usado
            String id_usuario = request.getParameter("id_usuario");

            String usuario = request.getParameter("user");
            String contrasenya = request.getParameter("pwd");
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            String telefono = request.getParameter("tel");
            String direccion = request.getParameter("dir");
            String email = request.getParameter("mail");

            String usuario_ori = request.getParameter("user_ori");
            String contrasenya_ori = request.getParameter("pwd_ori");
            String nombre_ori = request.getParameter("nombre_ori");
            String apellidos_ori = request.getParameter("apellidos_ori");
            String telefono_ori = request.getParameter("tel_ori");
            String direccion_ori = request.getParameter("dir_ori");
            String email_ori = request.getParameter("mail_ori");

            if (usuario.equals(usuario_ori) && contrasenya.equals(contrasenya_ori) && nombre.equals(nombre_ori) && apellidos.equals(apellidos_ori)
                    && telefono.equals(telefono_ori) && direccion.equals(direccion_ori) && email.equals(email_ori)) {
                response.sendRedirect("JSP/Sesion_iniciada.jsp");
            }
            
            else if (usuario.equals(usuario_ori)) {
                accesoBD con = new accesoBD();
                con.modificarDatos(id_usuario, usuario, contrasenya, nombre, apellidos, telefono, direccion, email);
                response.sendRedirect("JSP/Sesion_iniciada.jsp");
            } 
            
            else {
                int numero = 0;

                accesoBD con = new accesoBD();
                ResultSet usu = con.comprobarRepetido(usuario);

                while (usu.next()) {
                    numero = usu.getInt(1);
                }

                if (numero == 1) {
                    con.modificarDatos(id_usuario, usuario_ori, contrasenya, nombre, apellidos, telefono, direccion, email);
                    response.sendRedirect("JSP/Sesion_iniciada.jsp");
                } 
                
                else {
                    con.modificarNombrePedidos((String) request.getSession().getAttribute("usuario"), usuario);
                    con.modificarDatos(id_usuario, usuario, contrasenya, nombre, apellidos, telefono, direccion, email);
                    request.getSession().setAttribute("usuario", usuario);
                    response.sendRedirect("JSP/Sesion_iniciada.jsp");
                }
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(modificar_datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(modificar_datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

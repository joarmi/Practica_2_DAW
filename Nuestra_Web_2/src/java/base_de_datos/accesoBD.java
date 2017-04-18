/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package base_de_datos;

import java.sql.*;

/**
 *
 * @author Javier Argente Micó
 */
public class accesoBD {

    Connection conexionBD;

    public accesoBD() {
        conexionBD = null;
    }

    public void abrirConexionBD() {
        if (conexionBD == null) { // daw es el nombre de la base de datos que hemos creado con anterioridad.    
            String nombreConexionBD = "jdbc:mysql://localhost/mr_javiondo_gamer";
            try { // root y sin clave es el usuario por defecto que crea WAMPP.     
                Class.forName("com.mysql.jdbc.Driver");
                conexionBD = DriverManager.getConnection(nombreConexionBD, "root", "");
            } catch (Exception e) {
                System.out.println("No se ha podido conectar a la BB.DD...");
            }
        }
    }

    public boolean comprobarAcceso() {
        abrirConexionBD();
        return conexionBD != null;
    }
    
    public ResultSet obtenerProductosBD() {
        abrirConexionBD();
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT id_producto,nombre_producto,precio,descripcion FROM productos";
            resultados = s.executeQuery(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        return resultados;
    }
    
    public void realizarPedido(String nombre_usuario, String nombre_producto, float precio, int cantidad){
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO pedidos (nombre_usuario, nombre_producto, precio, cantidad, envio) "
                    + "VALUES ('" + nombre_usuario + "', '" +  nombre_producto + "', '" + precio 
                    + "', '" + cantidad + "', '0')";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }

    public ResultSet obtenerPedidosBD(String usuario) {
        abrirConexionBD();
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT id_pedido,nombre_usuario,nombre_producto,precio,cantidad FROM pedidos WHERE envio=0 AND nombre_usuario = '" + usuario + "'";
            resultados = s.executeQuery(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        return resultados;
    }
    
    public void modificarPedido(int id, int cantidad) {
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "UPDATE pedidos SET cantidad = '" + cantidad + "' WHERE id_pedido = '" + id + "';";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
    
    public void enviarPedido(int id) {
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "UPDATE pedidos SET envio = '1' WHERE id_pedido = '" + id + "';";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
    
    public void cancelarPedido(int id) {
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "DELETE FROM pedidos WHERE id_pedido = '" + id + "';";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
    
    public ResultSet obtenerUsuario(String usuario, String passwd){
        
        abrirConexionBD();
        ResultSet resultados = null;
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT COUNT(id_usuario) FROM usuarios WHERE usuario = '" + usuario + "' AND contrasenya = '" + passwd + "';";
            resultados = s.executeQuery(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        return resultados;
        
    }
    
    public ResultSet comprobarRepetido(String usuario){
        
        abrirConexionBD();
        ResultSet resultados = null;
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT COUNT(id_usuario) FROM usuarios WHERE usuario = '" + usuario + "';";
            resultados = s.executeQuery(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        return resultados;
        
    }
    
    public void registroUsuario(String usuario, String passwd, String nombre, String apellidos, String telefono, String direccion, String email){
        
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO usuarios (usuario, contrasenya, nombre, apellidos, telefono, direccion, email) "
                    + "VALUES ('" + usuario + "', '" +  passwd + "', '" + nombre +  "', '" + apellidos + "', '" + telefono
                    + "', '" + direccion + "', '" + email + "');";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
    
    public void registrarSugerencia(String sugerencia, String email){
        
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO sugerencias (sugerencia, email) "
                    + "VALUES ('" + sugerencia + "', '" +  email + "');";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
    
    public ResultSet obtenerDatos(String usuario){
        
        abrirConexionBD();
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT id_usuario, usuario, contrasenya, nombre, apellidos, telefono, direccion, email FROM usuarios WHERE usuario = '" + usuario + "'";
            resultados = s.executeQuery(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        return resultados;
        
    }
    
    public void modificarDatos(String id_usuario, String usuario, String contrasenya, String nombre, String apellidos, String telefono, String direccion, String email){
        
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "UPDATE usuarios SET usuario = '" + usuario + "', contrasenya = '" + contrasenya + "', nombre = '" + nombre + "', apellidos = '" + apellidos + "', telefono = '" + telefono + "', direccion = '"
                  + direccion + "', email = '" + email
                  + "' WHERE id_usuario = '" + id_usuario + "';";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
    
    public void modificarNombrePedidos(String id_usuario, String usuario){
        
        abrirConexionBD();
        ResultSet res;
        String user = null;
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT usuario FROM usuarios WHERE id_usuario = '" + id_usuario + "';";
            res = s.executeQuery(con);
            
            while(res.next()){
                user = res.getString(1);
            }
            
            con = "UPDATE pedidos SET nombre_usuario = '" + usuario + "' WHERE nombre_usuario = '" + user + "';";
            s.executeUpdate(con);
            
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        
    }
}

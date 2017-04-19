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

    // Funcion para obtener los productos que se mostraran en la tienda
    public ResultSet obtenerProductosBD() {
        abrirConexionBD();
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT id_producto,nombre_producto,precio,descripcion,stock FROM productos";
            resultados = s.executeQuery(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }
        return resultados;
    }

    // Funcion para crear un nuevo pedido utilizando los datos necesarios, donde nombre_usuario
    // es la variable de entorno con el nombre de ususario, teniendo en cuenta las unidades que quedan
    public void realizarPedido(String nombre_usuario, String nombre_producto, float precio, int cantidad, String id_producto) {
        abrirConexionBD();
        ResultSet resultados = null;
        int unidades = 0;

        try {
            String con;
            Statement s = conexionBD.createStatement();

            con = "SELECT stock FROM productos WHERE id_producto = '" + id_producto + "';";
            resultados = s.executeQuery(con);

            while (resultados.next()) {
                unidades = resultados.getInt(1);
            }

            if (unidades >= cantidad && cantidad > 0) {

                int nuevo_stock = unidades - cantidad;

                con = "UPDATE productos SET stock = '" + nuevo_stock + "' WHERE id_producto = '" + id_producto + "';";
                s.executeUpdate(con);

                con = "INSERT INTO pedidos (nombre_usuario, nombre_producto, precio, cantidad, envio) "
                        + "VALUES ('" + nombre_usuario + "', '" + nombre_producto + "', '" + precio
                        + "', '" + cantidad + "', '0')";
                s.executeUpdate(con);
            }
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }

    }

    // Funcion para obtener todos los pedidos de un usuario utilizando su nombre de usuario
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

    // Funcion utilizada para modificar la cantidad de productos de un pedido, utilizando para ello
    // el id del pedido y la nueva cantidad deseada, teniendo en cuenta las unidades del producto restantes
    public void modificarPedido(int id, int cantidad) {
        abrirConexionBD();
        ResultSet resultados = null;

        try {
            String con;
            Statement s = conexionBD.createStatement();
            String nombre_p = null;
            int cant = 0;
            int new_stock = 0;

            con = "SELECT nombre_producto, cantidad FROM pedidos WHERE id_pedido = '" + id + "';";
            resultados = s.executeQuery(con);

            while (resultados.next()) {
                nombre_p = resultados.getString(1);
                cant = resultados.getInt(2);
            }

            con = "SELECT stock FROM productos WHERE nombre_producto = '" + nombre_p + "';";
            resultados = s.executeQuery(con);

            while (resultados.next()) {
                new_stock = resultados.getInt(1);
            }

            if(cant != cantidad){
            
                if (cant - cantidad > 0 && cantidad != 0) {
                    new_stock += cant - cantidad;

                    con = "UPDATE productos SET stock = '" + new_stock + "' WHERE nombre_producto = '" + nombre_p + "';";
                    s.executeUpdate(con);

                    con = "UPDATE pedidos SET cantidad = '" + cantidad + "' WHERE id_pedido = '" + id + "';";
                    s.executeUpdate(con);

                } else if (cant - cantidad < 0) {

                    if (new_stock >= cantidad - cant) {

                        new_stock -= cantidad - cant;

                        con = "UPDATE productos SET stock = '" + new_stock + "' WHERE nombre_producto = '" + nombre_p + "';";
                        s.executeUpdate(con);

                        con = "UPDATE pedidos SET cantidad = '" + cantidad + "' WHERE id_pedido = '" + id + "';";
                        s.executeUpdate(con);

                    }

                } else if (cantidad == 0) {

                    new_stock += cant;
                    con = "UPDATE productos SET stock = '" + new_stock + "' WHERE nombre_producto = '" + nombre_p + "';";
                    s.executeUpdate(con);

                    con = "DELETE FROM pedidos WHERE id_pedido = '" + id + "';";
                    s.executeUpdate(con);

                }
                
            }

        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }

    }

    // Funcion utilizada para realizar el envio de un pedido
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

    // Funcion utilizada para eliminar un pedido, lo que implica que es borrado de la base de datos y
    // se aumenta el stock del respectivo producto
    public void cancelarPedido(int id) {
        abrirConexionBD();
        ResultSet resultados = null;

        try {
            String con;
            Statement s = conexionBD.createStatement();
            String nombre_p = null;
            int cant = 0;
            int new_stock = 0;

            con = "SELECT nombre_producto, cantidad FROM pedidos WHERE id_pedido = '" + id + "';";
            resultados = s.executeQuery(con);

            while (resultados.next()) {
                nombre_p = resultados.getString(1);
                cant = resultados.getInt(2);
            }

            con = "SELECT stock FROM productos WHERE nombre_producto = '" + nombre_p + "';";
            resultados = s.executeQuery(con);

            while (resultados.next()) {
                new_stock = resultados.getInt(1);
            }

            new_stock += cant;
            con = "UPDATE productos SET stock = '" + new_stock + "' WHERE nombre_producto = '" + nombre_p + "';";
            s.executeUpdate(con);

            con = "DELETE FROM pedidos WHERE id_pedido = '" + id + "';";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }

    }

    // Funcion utlizada para comprobar si las credenciales de inicio de sesion son correctas
    public ResultSet obtenerUsuario(String usuario, String passwd) {

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
    // Funcion utlizada para comprobar si un nombre de usuario ya esta siendo usado

    public ResultSet comprobarRepetido(String usuario) {

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

    // Funcion utlizada para registrar a un nuevo usuario en la base de datos
    public void registroUsuario(String usuario, String passwd, String nombre, String apellidos, String telefono, String direccion, String email) {

        abrirConexionBD();

        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO usuarios (usuario, contrasenya, nombre, apellidos, telefono, direccion, email) "
                    + "VALUES ('" + usuario + "', '" + passwd + "', '" + nombre + "', '" + apellidos + "', '" + telefono
                    + "', '" + direccion + "', '" + email + "');";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }

    }

    // Funcion utlizada para registrar las sugrencias en la base de datos
    public void registrarSugerencia(String sugerencia, String email) {

        abrirConexionBD();

        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO sugerencias (sugerencia, email) "
                    + "VALUES ('" + sugerencia + "', '" + email + "');";
            s.executeUpdate(con);
        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }

    }

    // Funcion utlizada para obtener todos los datos de un usuario utilizando su nombre de usuario
    public ResultSet obtenerDatos(String usuario) {

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
    // Funcion utlizada para modificar los datos de un usuario en la base de datos

    public void modificarDatos(String id_usuario, String usuario, String contrasenya, String nombre, String apellidos, String telefono, String direccion, String email) {

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

    // Funcion utlizada para modificar el nombre de usuario al que estan asociados los pedido cuando
    // el usuario modifica su nombre de usuario
    public void modificarNombrePedidos(String id_usuario, String usuario) {

        abrirConexionBD();
        ResultSet res;
        String user = null;

        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT usuario FROM usuarios WHERE id_usuario = '" + id_usuario + "';";
            res = s.executeQuery(con);

            while (res.next()) {
                user = res.getString(1);
            }

            con = "UPDATE pedidos SET nombre_usuario = '" + usuario + "' WHERE nombre_usuario = '" + user + "';";
            s.executeUpdate(con);

        } catch (Exception e) {
            System.out.println("Error ejecutando la consulta a la BB.DD....");
        }

    }
}

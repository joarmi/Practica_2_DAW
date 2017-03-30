/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package base_de_datos;

/**
 *
 * @author Javier Argente Micó
 */
public class pedido {

    private int id;
    private String nombre_usuario, nombre_producto;
    private float precio;
    private int cantidad;

    public int getId() {
        return id;
    }

    public String getNombre_usuario() {
        return nombre_usuario;
    }

    public String getNombre_producto() {
        return nombre_producto;
    }

    public float getPrecio() {
        return precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre_usuario(String nombre_usuario) {
        this.nombre_usuario = nombre_usuario;
    }

    public void setNombre_producto(String nombre_producto) {
        this.nombre_producto = nombre_producto;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
}

/*
 * @file product_model.js
 *
 * @brief Modelo de producto
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.idProducto,
        this.producto = '',
        this.descripcion = '',
        this.costoUnitario,
        this.photo,
        this.enabled,
    });

    int idProducto;
    String producto;
    String descripcion;
    double costoUnitario;
    String photo;
    bool enabled;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProducto     : json["id_producto"],
        producto       : json["producto"],
        descripcion    : json["descripcion"],
        costoUnitario  : json["costo_unitario"] / 1,
        photo          : json["photo"],
        enabled        : json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "idProducto"    : idProducto,
        "producto"      : producto,
        "descripcion"   : descripcion,
        "costoUnitario" : costoUnitario,
        "photo"         : photo,
        "enabled"       : enabled,
    };
}

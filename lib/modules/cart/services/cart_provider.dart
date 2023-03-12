import 'package:flutter/cupertino.dart';

import '../../add_instrument/models/instrument.dart';

class CartProvider extends ChangeNotifier {
  final List<Instrumento> _carProducts = [];
  List<Instrumento> get carProducts => _carProducts;

  double _totalAPagarProducto = 0;

  double get totalAPagarProducto => _totalAPagarProducto;
  set totalAPagarProducto(double value) {
    _totalAPagarProducto = value;
    notifyListeners();
  }

  calcularPago(bool aumentar, Instrumento producto) {
    for (var prod in _carProducts) {
      if (producto.nombre == prod.nombre) {
        if (aumentar) {
          _totalAPagarProducto =
              _totalAPagarProducto + double.parse(producto.precio);
        } else {
          _totalAPagarProducto =
              _totalAPagarProducto - double.parse(producto.precio);
        }
        return;
      }
    }
  }

  addProductCar(Instrumento prod) {
    bool existProduct = false;

    //verifiamos si el carrito de compra esta vacio
    if (_carProducts.isEmpty) {
      _carProducts.add(prod);
      _totalAPagarProducto = 0;
      calcularPago(true, prod);
      return;
    }
    for (var product in _carProducts) {
      //Buscamos si el producto ya se encuentra dentro del carrito
      if (prod.nombre == product.nombre) {
        //Aumentamos uno mas
        product.cantidad++;
        existProduct = true;
      }
    }
    //Si no existe el producto se guarda el nuevo producto
    if (!existProduct) {
      _carProducts.add(prod);
    }
    calcularPago(true, prod);
    notifyListeners();
  }

  limpiarCarrito() {
    _carProducts.clear();
    notifyListeners();
  }

  deleteProduct(Instrumento producto) {
    if (producto.cantidad > 1) {
      for (var p in _carProducts) {
        if (p.nombre == producto.nombre) {
          p.cantidad--;
        }
      }
    } else {
      _carProducts.remove(producto);
    }
    calcularPago(false, producto);
  }
}

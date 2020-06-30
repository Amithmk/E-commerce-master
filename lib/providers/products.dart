import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'SUKHOI 30 MKI',
      description: 'Air Dominance Fighter',
      price: 50000000,
      imageUrl:
          'https://english.cdn.zeenews.com/sites/default/files/2019/07/23/805799-sukhoi-su-30mki.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Dassult Rafale',
      description: 'Multi role medium combat Aircraft',
      price: 12000000,
      imageUrl:
          'https://c.ndtvimg.com/2019-10/nhadom54_rafalejet650_625x300_09_October_19.jpg',
    ),
    Product(
      id: 'p3',
      title: 'S-400 Missile',
      description: 'Advanced Air defence System',
      price: 99000000,
      imageUrl:
          'https://www.popsci.com/sites/popsci.com/files/styles/1000_1x_/public/s-400_ausa_airpower.jpg?itok=xiiNe06O',
    ),
    Product(
      id: 'p4',
      title: 'AK-203 Assault Rifle',
      description: 'Prepare any meal you want.',
      price: 9999,
      imageUrl:
          'https://lh3.googleusercontent.com/proxy/Ru1cjJPPaRL62RH_Tn36tcZdFiNKSn05GPPMCdT0M8LrMY6alPVQW0UxivAQNsrvAAMyw7djOb9fnmEDtqLPOXPfTThkplSDJ35BcXWJEejcZt4',
    ),
    Product(
      id: 'p5',
      title: 'ARJUN MAIN BATTLE TANK',
      description: 'A made in India product!',
      price: 50000,
      imageUrl:
      'https://www.indiandefencetimes.com/wp-content/uploads/2019/12/arjun-tank-ndtv_650x400_41515397955.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Brahmos Cruise missile',
      description: 'A super sonic cruise missile',
      price: 99999,
      imageUrl:
      'https://www.india.com/wp-content/uploads/2016/08/BrahMos-missile-.jpg',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    const url = 'https://e-commerce-939d4.firebaseio.com/products.json';
    http.post(url, body: json.encode({
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isFavorite,
    }),);
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();  
  }
    
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
 
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}

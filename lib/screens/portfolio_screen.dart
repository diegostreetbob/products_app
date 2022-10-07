////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import "package:products_app/screens/screens.dart";
import 'package:products_app/services/product_service.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
class PortfolioScreen extends StatelessWidget {
  static const String route = "portfolioScreen";//Ruta de esta pantalla
  @override
  Widget build(BuildContext context) {
    final productsServices = Provider.of<ProductsService>(context);
    //
    if(productsServices.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: ListView.builder(
          itemCount: productsServices.products.length,
          itemBuilder: (BuildContext context, int index)=>GestureDetector(
            onTap:()=> Navigator.pushNamed(context, ProductScreen.route,arguments:productsServices.products[index] ),
            child: ProductCard(product: productsServices.products[index])
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, ProductScreen.route,arguments: Product(available: false, name: "", price: 0));
          },
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////


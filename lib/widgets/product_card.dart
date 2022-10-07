////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import '../models/models.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
class ProductCard extends StatelessWidget {
  //Atributos
  final Product product;
  //Constructor
  const ProductCard({required this.product});
  //Operaciones
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 50),
          width: double.infinity,
          height: 400,
          decoration: _cardDecoration(),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _BackGroundImage(this.product.picture),
              _ProductDetails(product:this.product),
              Positioned(child: _PriceTag(price:product.price),top: 0,right: 0),
              Positioned(child: _NotAvailable(avalaible: product.available),top: 0,left: 0)//todo mostrar de manera condicional
            ],
          )),
    );
  }

  //
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))]);
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _BackGroundImage extends StatelessWidget {
  String? urlImage;
  _BackGroundImage(this.urlImage);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
          width: double.infinity,
          height: 400,
          color: Colors.white,
          child:urlImage == null ? const Image(image: AssetImage("assets/images/no-image.png"),fit: BoxFit.cover):
          FadeInImage(
            // todo productos cuando no hay imagen
            placeholder: const AssetImage("assets/images/jar-loading.gif"),
            image: NetworkImage(urlImage!),//"https://via.placeholder.com/400x300/f6f6f6"
            fit: BoxFit.cover, //para que ocupe all el espacio del contenedor
          )),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _ProductDetails extends StatelessWidget {
  Product product;

  _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _productsDetailDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.product.name,
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis
            ),
            Text(this.product.id ?? "--",style: TextStyle(fontSize: 15, color: Colors.white),maxLines: 1
            ),
          ],
        ),
      ),
    );
  }
  BoxDecoration _productsDetailDecoration() {
    return const BoxDecoration(
      color: Colors.indigo,//todo centralizar este valor en un tema
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topRight: Radius.circular(25)
      ),
      );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _PriceTag extends StatelessWidget {
  double price = 0;

  _PriceTag({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(//adapta el tamaño del texto al espacio disponible
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(price.toString()+"€", style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _NotAvailable extends StatelessWidget {
  bool avalaible;

  _NotAvailable({required this.avalaible});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FittedBox(//adapta el tamaño del texto al espacio disponible
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                avalaible ? "Disponible":"No disponible",
                style: TextStyle(fontSize: 20, color: avalaible ? Colors.green: Colors.red)),
          ),
        ),
        alignment: Alignment.center,
        width: 100,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.yellow[800],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25))
        )
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
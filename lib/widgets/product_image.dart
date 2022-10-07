////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import 'dart:io';
////////////////////////////////////////////////////////////////////////////////////////////////////
class ProductImage extends StatelessWidget {
  String? urlImage;
  ProductImage(this.urlImage);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left: 10, right: 10, top: 10 ),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(//para dar transparencia y que se vean los iconos si la imagen tiene fondo blanco
          opacity: 0.95,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular( 45 ), topRight: Radius.circular(45)),
            child: getImage(urlImage)
            ),
          ),
        )
    );
   }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.black,
      borderRadius: const BorderRadius.only( topLeft: Radius.circular( 45 ), topRight: Radius.circular(45) ),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0,5)
        )
      ]
  );
  Widget getImage(String? urlImage){
    if(urlImage == null){
      return const Image(
          image: AssetImage("assets/images/no-image.png"),
          fit: BoxFit.cover
      );
    }
    //
    if (urlImage.startsWith("http")){
      return FadeInImage(
          image: NetworkImage(urlImage!),
          placeholder: const AssetImage("assets/images/jar-loading.gif"),
          fit: BoxFit.cover
      );
    }
    //
    return Image.file(
       File(urlImage),
       fit: BoxFit.cover
     );


  }

}
////////////////////////////////////////////////////////////////////////////////////////////////////

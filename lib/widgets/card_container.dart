////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
class  CardContainer extends StatelessWidget {
  //Atributos
  final Widget child;
  //Constructor
  const CardContainer({super.key, required this.child});
  //Operaciones
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: _boxDecoration(),
          child: this.child
        ),
      );
  }
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow:[
        BoxShadow(//Sobnbra
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0,5)//posición de la sombra
        )
      ]
      );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

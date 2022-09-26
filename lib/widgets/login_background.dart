////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
class LoginBackGround extends StatelessWidget {
  //Atributos
  final Widget child;
  //Constructor
  const LoginBackGround({super.key, required this.child});
  //Operaciones
  @override
  Widget build(BuildContext context) {
      return Container(
        //color: Colors.red,
        width: double.infinity,
        height:double.infinity,
        child: Stack(
          children: [
            _PurpleBox(),
            _IconoPersona(),
            this.child
        ],
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _IconoPersona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(//con este evitamos que se solape la imagen arriba en teléfonos con noths
      child: Container(
        width: double.infinity,
        child: const Icon(Icons.person_pin, color: Colors.white,size: 100),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class  _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return Container(
        width: double.infinity,
        height: size.height * 0.4,
        decoration: _purpleBoxDecoration(),
        //Circulitos de fondo
        child: Stack(
          children: [
            //Positioned solo funciona dentro de Stack, es para posicionar elementos
            Positioned(top: 10, left: -10, child: _Bubble()),
            Positioned(top: 140,left: 130, child: _Bubble()),
            Positioned(top: 240,left: 20, child: _Bubble()),
            Positioned(top: 210,left: 300, child: _Bubble()),
            Positioned(top: 60, left: 270, child: _Bubble()),
          ],
        ),
    );
  }
  //Operaciones
  BoxDecoration _purpleBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(92, 70, 178, 1)
      ]
    )
  );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class  _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Container(
        width: 100,
        height:100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)
        ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////




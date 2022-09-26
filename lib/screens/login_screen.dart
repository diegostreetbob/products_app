////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../Styles/input_decorations.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/screens/screens.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
class LoginScreen extends StatelessWidget {
  //Ruta de esta pantalla
  static const String route = "loginScreen";
  //Constructor
  const LoginScreen({Key? key}) : super(key: key);
  //Operaciones
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackGround(
          child: SingleChildScrollView(
              child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text("Authentication", style: Theme.of(context).textTheme.headline5),
              const SizedBox(height: 10),
              _LoginForm()
            ],
          )),
          const SizedBox(height: 50),
          const Text("Crear una nueva cuenta",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        ],
      ))),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _LoginForm extends StatelessWidget {
  //Atributos

  //Constructor
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //uso del provider
    final loginForm = Provider.of<LoginFormProvider>(context);
    //
    return Container(
      child: Form(
        //Mantener la referencia al key, se usa en el provider
        key: loginForm.formKey,//formKey declarado en el provider
        //autovalidateMode: AutovalidateMode.onUserInteraction,//valida mientras escribimos
        //no me gusta porque hasta que ho has terminado de rellenar el campo te está mostrando
        //el error.
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.loginInputDecoration(
                    prefixIcon: const Icon(Icons.alternate_email_rounded, color: Colors.deepPurple),
                    hintText: 'john.doe@gmail.com',
                    labelText: 'E-Mail'
                ),
                onChanged: (value){
                  loginForm.email = value;//guardamos valor del campo en el atributo del provider
                },
                validator: (value){//cuando retorna null es que la validación pasó.
                //
                String validEmailpattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(validEmailpattern);
                //
                return regExp.hasMatch(value ?? "")?null: "Non valid email";
              }
            ),
            const SizedBox(height: 20),
            TextFormField(
                autocorrect: false,
                obscureText: true, //se va ocultando mientras escribimos.
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorations.loginInputDecoration(
                    prefixIcon: const Icon(Icons.security_rounded, color: Colors.deepPurple),
                    hintText: '******',
                    labelText: 'Password'
                ),
                onChanged: (value){
                  loginForm.password = value;//guardamos valor del campo en el atributo del provider
                },
                validator: (value){//cuando retorna null es que la validación pasó.
                  //retorna null si la validación es válida
                  return value != null && value.length>=6 ? null:"Non valid pass";
                }
            ),
            const SizedBox(height: 20),
            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                //Si está cargando desactivo botón poniéndolo a null
                onPressed:loginForm.isLoading ? null: () async {
                  FocusScope.of(context).unfocus();//esconde el teclado
                  if(loginForm.isValidForm()==true){
                    loginForm.isLoading = true;
                    await Future.delayed(Duration(seconds: 2));//simulamos respuesta de un servicio externo
                    loginForm.isLoading = false;
                    Navigator.pushReplacementNamed(context, HomeScreen.route);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
                  child: Text(//texto en función de lo que diga el provider
                    loginForm.isLoading ? "Wait...":"Login",
                      style: const TextStyle(color: Colors.white)
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
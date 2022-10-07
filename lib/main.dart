////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/providers/product_form_provider.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
void main() {
  runApp(
  MultiProvider(
    //capa de servicios inyectada
      providers: [
        ChangeNotifierProvider<ProductsService>(create: (_)=>ProductsService()),
        ChangeNotifierProvider<LoginFormProvider>(create: (_)=>LoginFormProvider()),
        ChangeNotifierProvider<AuthService>(create: (_)=>AuthService(),lazy: false)
  ],
  child: MyApp()
  )
  );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      //initialRoute: LoginScreen.route,//todo para pruebas dejo esto comentado
      initialRoute: LoginScreen.route,
      routes: {
        PortfolioScreen.route   :(_) => PortfolioScreen(),
        LoginScreen.route       :(_) => LoginScreen(),
        ProductScreen.route     :(_) => ProductScreen(),
        RegisterScreen.route    :(_) => RegisterScreen()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme:const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

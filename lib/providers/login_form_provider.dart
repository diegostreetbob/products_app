////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
class LoginFormProvider extends ChangeNotifier {
  //Conectamos el key del cada campo del formulario a este provider
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool _isLoading = false;

  bool isValidForm(){
    bool res = formKey.currentState?.validate() ?? false;
    return res;
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();//notificamos a todos los que escuchan este provider
  }
  bool get isLoading => _isLoading;

}
////////////////////////////////////////////////////////////////////////////////////////////////////

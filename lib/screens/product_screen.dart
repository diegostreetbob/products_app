////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import '../Styles/input_decorations.dart';
import '../models/product.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:products_app/providers/product_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
class ProductScreen extends StatelessWidget {
  //Atributos
  static const String route = "productScreen"; //Ruta de esta pantalla
  //Constructor
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //argumeentos que viene desde PortfolioScreen
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return ChangeNotifierProvider(
        create: (_)=>ProductFormProvider(product),
        child: _ProductScreenBody(product: product)
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final productsServices = Provider.of<ProductsService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,//se oculta al hacer scroll
        child: Column(
          children: [
            //primera fila de la columna
            Stack(
              children: [
                ProductImage(product.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 40),
                      color: Colors.indigo[100],
                      onPressed: () => Navigator.of(context).pop(), //sale de esta pantalla
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.camera, size: 40),
                      color: Colors.indigo[100],
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final XFile? photo = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
                        if (photo == null){
                          //print("No ha seleccionado nada");
                          return;
                        }else{
                          product.picture = photo.path;
                          productsServices.updateSelectedProductImage(photo.path);
                          //print("Tenemos imagen "+photo.path);
                        }
                      }, //todo gestionar camara
                    ))
              ],
            ),
            //Segunda fila de la columna
            _ProductForm(),
            SizedBox(height: 100) //para dar un poco mas de espacio para Scrool
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: (){
          if(!productForm.isValidForm()){
            return;
          }else{
            productsServices.saveOrCreateProduct(product);
          }

        },//Guardar producto
      )
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    Product product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 200,
        decoration: _productFormDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name.toString(),
                onChanged: (value)=>product.name = value,
                validator: (value){
                  //!(value == null || value.length<1)? "Campo requerido":value;
                  if(value == null || value.length<1){
                    return "Campo requerido";
                  }
                },
                decoration: InputDecorations.loginInputDecoration(
                    prefixIcon: const Icon(Icons.text_fields),
                    hintText : "Escriba el nombre del producto",
                    labelText: product.name.toString()
                )
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [//solo numeros un punto y solo dos decimales
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  initialValue: product.price.toString(),
                  onChanged: (value) {
                    //si se puede, o no parsear
                    if(double.tryParse(value)==0){
                      product.price = 0;
                    }else{
                      product.price = double.parse(value);
                    }
                  },
                  validator: (value){
                    //!(value == null || value.length<1)? "Campo requerido":value;
                    if(value == null || value.length<1){
                      return "Campo requerido";
                    }
                  },
                  decoration: InputDecorations.loginInputDecoration(
                      prefixIcon: const Icon(Icons.euro),
                      hintText : "Precio del producto",
                      labelText: product.price.toString()
                  )
              ),
              //const SizedBox(height: 10),
              SwitchListTile.adaptive(
                  value: product.available,
                  title: Text(product.available ? "Disponible":"No disponible"),
                  activeColor: Colors.indigo,
                  onChanged: (value)=>productForm.updateAvailability(value)
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _productFormDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius:
            const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.005), offset: Offset(0, 5), blurRadius: 5)
        ]);
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

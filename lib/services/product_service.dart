////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:products_app/models/models.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
class ProductsService extends ChangeNotifier{
  final String _urlBase = "flutter-productos-app-cff6f-default-rtdb.firebaseio.com";
  final String _endPointCloudinary = "https://api.cloudinary.com/v1_1/dol29akkx/image/upload?upload_preset=productos_app_flutter";
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  File? pictureFile;
  //Constructor
  ProductsService(){
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async{
    this.isLoading = true;
    notifyListeners();//notifico que estamos cargando
    final url = Uri.https(_urlBase,"products.json");
    final resp = await http.get(url);
    //
    final Map<String,dynamic> productsMap = jsonDecode(resp.body);
    print(productsMap);
    //pasamos de mapa a list
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });
    this.isLoading = false;
    notifyListeners();//notifico que estamos cargando
    return this.products;
  }
  Future saveOrCreateProduct(Product product) async{
    isSaving = true;
    notifyListeners();
    //
    if(product.id == null){
      await _createProduct(product);
    }else{
      await _updateProduct(product);
    }

    //
    isSaving = false;
    notifyListeners();
  }
  Future<String> _updateProduct(Product product)async{
    product.picture = await uploadImage(product.picture!);
    final url = Uri.https(_urlBase,"products/${product.id}.json");
    final resp = await http.put(url,body: product.toJson());
    final decodedData = resp.body;
    return product.id!;
  }
  Future<String> _createProduct(Product product)async{
    product.picture = await uploadImage(product.picture!);
    final url = Uri.https(_urlBase,"products.json");
    final resp = await http.post(url,body: product.toJson());
    final decodedData = jsonDecode(resp.body);
    product.id = decodedData["name"];//la respuesta de firebase es esta {"name":"-NDNLAPRydLgvRrkknK2"}
    this.products.add(product);
    return product.id!;
  }
  void updateSelectedProductImage(String path){
    this.pictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }
  Future<String?> uploadImage(String path) async{
    if(this.pictureFile == null) return null;
    //
    this.isSaving = true;
    notifyListeners();
    //
    final url = Uri.parse(_endPointCloudinary);
    //crear request
    final imageUploadRequest = http.MultipartRequest("POST",url);
    //creamos archivos
    final file = await http.MultipartFile.fromPath("file",path!);
    //añadimos archivos
    imageUploadRequest.files.add(file);
    //realizamos la petición
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    //
    if(response.statusCode !=200 && response.statusCode !=201){
      print("Error subiendo imagen");
      //print(response.body);
      return null;
    }
    final decodedData = json.decode(response.body);
    //
    this.isSaving = false;
    notifyListeners();
    //
    return decodedData["secure_url"];




  }

}
////////////////////////////////////////////////////////////////////////////////////////////////////

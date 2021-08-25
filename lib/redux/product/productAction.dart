import 'package:flutterapp/redux/appReducer.dart';
import 'package:flutterapp/redux/product/productReducer.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
//redux
import 'package:redux/redux.dart';

@immutable
class GetProductAction {
  final ProductState productState;

  GetProductAction({this.productState});
}

//action
getProductAction(Store<AppState> store) async {
  try {
    store.dispatch(
        GetProductAction(productState: ProductState(isLoading: true)));

    var url = Uri.parse('https://api.codingthailand.com/api/course');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final Map<String, dynamic> product = convert.jsonDecode(response.body);
      store.dispatch(GetProductAction(
          productState:
              ProductState(course: product['data'], isLoading: false)));
    } else {
      //error 400, 500
      store.dispatch(GetProductAction(
          productState: ProductState(course: [], isLoading: false)));
    }
  } catch (e) {
    store.dispatch(GetProductAction(
        productState: ProductState(course: [], isLoading: false)));
  }
}

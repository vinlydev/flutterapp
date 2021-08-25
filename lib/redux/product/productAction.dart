import 'package:flutterapp/redux/product/productReducer.dart';
import 'package:meta/meta.dart';

@immutable
class GetProductAction {
  final ProductState productState;

  GetProductAction({this.productState});
}

//action
getProductAction() {}

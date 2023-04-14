import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial(products: [])) {
    on<ProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

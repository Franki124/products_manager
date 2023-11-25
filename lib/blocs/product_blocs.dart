import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_manager/blocs/product_events.dart';
import 'package:products_manager/blocs/product_state.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductsBloc() : super(ProductInitialState()) {
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onCreateProduct(CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      await _firestore.collection('products').add({
        'name': event.product.name,
        'description': event.product.description,
        'price': event.product.price,
        'history': event.product.history,
      });
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      await _firestore.collection('products').doc(event.product.id.toString()).update({
        'name': event.product.name,
        'description': event.product.description,
        'price': event.product.price,
        'history': event.product.history,
      });
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      await _firestore.collection('products').doc(event.productId).delete();
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}

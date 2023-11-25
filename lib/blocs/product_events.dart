import '../models/product.dart';

abstract class ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final Product product;
  CreateProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  UpdateProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final String productId;
  DeleteProductEvent(this.productId);
}
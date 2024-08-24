

part of 'product_bloc.dart';
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;
  SearchProductsEvent(this.query);
}


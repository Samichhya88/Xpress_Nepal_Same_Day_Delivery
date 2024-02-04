part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class SelectedItems extends CartState {
  final List<CartItem> checkedItems;

  SelectedItems(this.checkedItems);
}

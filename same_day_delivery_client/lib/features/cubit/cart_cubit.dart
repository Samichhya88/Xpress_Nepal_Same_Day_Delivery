import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:same_day_delivery_client/model/cart.item.model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final List<CartItem> items = [];
  CartCubit() : super(CartInitial());

  void selectItem(CartItem item) {
    if (items.contains(item)) {
      items.remove(item);
    } else {
      items.add(item);
    }
    emit(SelectedItems(items));
  }

  void unSelectItem(CartItem item) {
    emit(SelectedItems(items));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customScaffold.dart';
import 'package:same_day_delivery_client/features/cubit/cart_cubit.dart';
import 'package:same_day_delivery_client/model/cart.item.model.dart';
import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> cartItems = [
    {
      "productName": "Running Shoes",
      "shopName": "Sports Emporium",
      "price": 700,
      "quantity": 2,
      "isChecked": false
    },
    {
      "productName": "Wireless Earbuds",
      "shopName": "Gadget Hub",
      "price": 400,
      "quantity": 2,
      "isChecked": true
    },
    {
      "productName": "Laptop Backpack",
      "shopName": "Tech Accessories Store",
      "price": 800,
      "quantity": 3,
      "isChecked": false
    },
    {
      "productName": "Smartwatch",
      "shopName": "Electronics World",
      "price": 900,
      "quantity": 1,
      "isChecked": true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const CartPageAppBar(),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Expanded(
              child: FutureBuilder(
                future: LocalStorage.getCartItems(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModel>?> snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                        onRefresh: () async {
                          setState(() {});
                        },
                        child: ListView.builder(
                            addAutomaticKeepAlives: true,
                            cacheExtent: snapshot.data!.length.toDouble(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ItemDetail(
                                cartItem: CartItem.fromProductModel(
                                    snapshot.data![index]),
                              );
                            }));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text("No items in cart"),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text("Refresh"),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Container(
                  height: 82,
                  color: const Color.fromARGB(255, 240, 239, 239),
                  child: ItemsCheckout(cartItems: cartItems)),
            )
          ],
        ),
      ),
    );
  }
}

class CartPageAppBar extends StatelessWidget {
  const CartPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          "Cart",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            await LocalStorage.clearCartItems();
          },
          child: const Text(
            "Clear",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 162, 123, 6),
            ),
          ),
        ),
      ],
    );
  }
}

class ItemDetail extends StatefulWidget {
  final CartItem cartItem;

  const ItemDetail({Key? key, required this.cartItem}) : super(key: key);

  @override
  _ItemCountState createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemDetail> {
  int quantity = 0;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity;
    isChecked = widget.cartItem.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = widget.cartItem;

    return BlocProvider(
      create: (context) => CartCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          height: 120,
          width: double.infinity,
          child: Row(
            children: [
              Checkbox(
                activeColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey,
                ),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                    context.read<CartCubit>().selectItem(cartItem);
                  });
                },
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  width: 130,
                  image: NetworkImage(
                    cartItem.imageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartItem.title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd()
                        .format(DateTime.parse(cartItem.addedDate)),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 10,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price:Rs. ${cartItem.price}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemsCheckout extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const ItemsCheckout({Key? key, required this.cartItems}) : super(key: key);

  @override
  _ItemsCheckoutState createState() => _ItemsCheckoutState();
}

class _ItemsCheckoutState extends State<ItemsCheckout> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> checkedItems =
        widget.cartItems.where((item) => item['isChecked'] == true).toList();

    int deliveryPrice = 65;
    int totalPrice = checkedItems.fold<int>(
        0,
        (sum, item) =>
            sum + (item['price'] as int) * (item['quantity'] as int));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Price (estimated): Rs. $deliveryPrice",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 150, 150, 150),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is SelectedItems) {
                        totalPrice = state.checkedItems.fold<int>(
                            0,
                            (sum, item) =>
                                sum + (item.price * item.quantity).toInt());
                        return Text(
                          "Total Price: Rs. $totalPrice",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        );
                      }
                      return Text(
                        "Select items to continue",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return CustomButton(
                    text: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if (state is SelectedItems) {
                        if (state.checkedItems.isNotEmpty) {
                          print("cart items: ${state.checkedItems}");
                          goRouter.go('/cart/checkout',
                              extra: {"cartItems": state.checkedItems});
                          return;
                        }
                      }
                      showCustomSnackBar(context,
                          message: "You have no items selected");
                      return;
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

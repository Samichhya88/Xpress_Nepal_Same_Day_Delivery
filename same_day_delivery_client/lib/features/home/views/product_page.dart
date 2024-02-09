import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customScaffold.dart';
import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;
  const ProductPage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                )),
          ),
        ),
        title: ProductPageAppBar(product: product),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductTitle(
                product: product,
              ),
              CategorySection(
                product: product,
              ),
              //Category
              //Price
              PriceSection(
                product: product,
              ),
              //Image
              ImageSection(
                product: product,
              ),
              //Description
              const SizedBox(
                height: 20,
              ),
              DescriptionSection(
                product: product,
              ),
              //spacer
              // Spacer(),
              //Action Button
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 40.0,
          left: 20,
          right: 20,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1, // smaller size
              child: CustomButton(
                onPressed: () async {
                  final saved =
                      await LocalStorage.saveCartitems(cartItems: [product]);
                  if (!saved) {
                    showCustomSnackBar(context,
                        message: "Something went wrong");
                  }
                  showCustomSnackBar(
                    context,
                    message: "Item added to cart",
                    color: Colors.green,
                    icon: Icons.check_circle,
                    headingText: "Success",
                  );
                },
                text: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.shopping_cart_checkout,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final ProductModel product;
  const ImageSection({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: NetworkImage(
            product.productImage,
          ),
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 40,
                  ),
                  Text(
                    "Image Not Found",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              )),
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final ProductModel product;
  const DescriptionSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Stack(
        children: [
          Text(
            product.productDescription,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.white.withOpacity(0.9),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            product.productDescription,
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 10,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Text(
                  "Read More",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PriceSection extends StatelessWidget {
  final ProductModel product;
  const PriceSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Text(
        "Rs. ${product.productPrice.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final ProductModel product;
  const CategorySection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 200,
      child: Text(
        DateFormat.yMMMd().format(DateTime.parse(product.productDate)),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}

class RatingSection extends StatelessWidget {
  const RatingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //Rating Section
      height: 35,
      width: 200,
      color: Colors.grey[200],
    );
  }
}

class ProductTitle extends StatelessWidget {
  final ProductModel product;
  const ProductTitle({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 180,
      child: Text(
        product.productName,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}

class ProductPageAppBar extends StatelessWidget {
  final ProductModel product;
  const ProductPageAppBar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          product.productName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const Spacer(),
        Icon(
          Icons.shopping_bag,
          size: 25,
          color: Colors.grey[800],
        ),
      ],
    );
  }
}

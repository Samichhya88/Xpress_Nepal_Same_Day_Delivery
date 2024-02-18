import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:same_day_delivery_client/features/home/views/home_page.dart';
import 'package:same_day_delivery_client/services/api.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;
  const SearchPage({super.key, required this.searchQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Search Results for: ${widget.searchQuery}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            FutureBuilder(future: ApiService.searchProducts(widget.searchQuery), builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } 
                else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Products Found"),
                  );
                }
                else {
                  return Expanded(
                    child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 25,
                            childAspectRatio: .9,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(
                                    "/product/${snapshot.data![index].productId}",
                                    extra: {
                                      "product": snapshot.data![index],
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 200,
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image(
                                        height: 120,
                                        image: NetworkImage(
                                            snapshot.data![index].productImage),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                              height: 90,
                                              color: Colors.grey[200],
                                              child: const Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    "Image Not Found",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              )));
                                        },
                                        width: double.infinity,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Best Seller",
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      snapshot.data![index].productName
                                          .toString(),
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Rs. ${snapshot.data![index].productPrice.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          const Spacer(),
                                          const LoveButton(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  );
                }
              } else {
                return Text('Error: Unknown');
              }
            }),
          ],
        ),
      ),
    );
  }
}
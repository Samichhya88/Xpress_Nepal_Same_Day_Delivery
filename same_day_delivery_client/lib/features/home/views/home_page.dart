import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/services/api.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Explore",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Search Section
            SearchBar(),
            //Product Section
            BestSellerSection(),
            // BestSellerSection(),
          ],
        ),
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int activeindex = 1;
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: activeindex == index ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: activeindex == index
                  ? Border.all(
                      color: Colors.black,
                      width: 1,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                "Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      activeindex == index ? FontWeight.bold : FontWeight.w500,
                  color: activeindex == index ? Colors.white : Colors.grey[800],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 250),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Best Seller",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[800],
                  ),
                ),
                const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: ApiService.getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        ApiService.getProducts();
                      },
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class LoveButton extends StatefulWidget {
  const LoveButton({
    super.key,
  });

  @override
  State<LoveButton> createState() => _LoveButtonState();
}

class _LoveButtonState extends State<LoveButton> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        onPressed: () {
          setState(() {
            isLoved = !isLoved;
          });
        },
        icon: Icon(
          isLoved ? Icons.favorite : Icons.favorite_border,
          color: isLoved ? Colors.red : Colors.grey[800],
          size: 15,
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: searchController,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                searchController.text = value;
              },
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (searchController.text.isNotEmpty) {
              GoRouter.of(context)
                  .push("/search/${searchController.text}", extra: {
                "query": searchController.text,
              });
            }
            return;
          },
          child: Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.search, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:go_router/go_router.dart';
import 'package:same_day_delivery_client/components/scaffold_with_navBar.dart';
import 'package:same_day_delivery_client/features/auth/views/login_screen.dart';
import 'package:same_day_delivery_client/features/auth/views/register_screen.dart';
import 'package:same_day_delivery_client/features/cart/views/cart_page.dart';
import 'package:same_day_delivery_client/features/cart/views/checkout_page.dart';
import 'package:same_day_delivery_client/features/home/views/home_page.dart';
import 'package:same_day_delivery_client/features/home/views/product_page.dart';
import 'package:same_day_delivery_client/features/profile/views/profile_page.dart';
import 'package:same_day_delivery_client/features/search/page.dart';
import 'package:same_day_delivery_client/features/socket/riderSelectPage.dart';
import 'package:same_day_delivery_client/model/cart.item.model.dart';
import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:same_day_delivery_client/services/api.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      name: "login",
      path: "/login",
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      name: "signup",
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) {
        return RegisterPage();
      },
    ),
    // GoRoute(
    //   name: "default",
    //   path: "/",
    //   routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                name: "home",
                path: "/",
                builder: (BuildContext context, GoRouterState state) {
                  return HomePage();
                },
                routes: <RouteBase>[]),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              name: "cart",
              path: "/cart",
              builder: (BuildContext context, GoRouterState state) {
                return CartPage();
              },
              routes: <RouteBase>[
                GoRoute(
                    path: 'checkout',
                    builder: (BuildContext context, GoRouterState state) {
                      final cartItems =
                          (state.extra as Map)['cartItems'] as List<CartItem>;
                      print("cartItems: $cartItems");
                      return CheckoutPage(
                        cartItems: cartItems,
                      );
                    }),
                GoRoute(
                  path: 'riderPage',
                  pageBuilder: (context, state) {
                    GeoPoint startPoint =
                        (state.extra as Map)["startingPoint"] as GeoPoint;
                    GeoPoint endPoint =
                        (state.extra as Map)["endpoint"] as GeoPoint;
                    print(startPoint);
                    return MaterialPage(
                        child: RiderSelectPage(
                            startPoint: startPoint, endPoint: endPoint));
                  },
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: "profile",
                path: "/profile",
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfilePage();
                }),
          ]),
        ]),
    // ]),
    GoRoute(
        path: "/product/:id",
        builder: (context, state) {
          final p = (state.extra as Map)["product"];
          ProductModel productDetails = p as ProductModel;

          return ProductPage(product: productDetails);
        }),
    GoRoute(path: '/search/:query', builder: (context, state) {
      print("state.extra: ${state.extra}");
      final String query = (state.extra as Map)["query"].toString();
      return SearchPage(searchQuery:query );
    }),
  ],
  //   )
  // ],
);

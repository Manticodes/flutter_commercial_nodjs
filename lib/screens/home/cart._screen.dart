import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/screens/home/home_widgets.dart';

import '../../logic/bloc_user/user_bloc.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Product2> _products = [
    Product2(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Product 1',
      price: '19.99',
      quantity: 1,
    ),
    Product2(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Product 2',
      price: '29.99',
      quantity: 1,
    ),
    Product2(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Product 3',
      price: '39.99',
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalPriceWithDiscount = 0;
    void calculateTotal(UserState state) {
      for (var i = 0; i < state.user.cart.length; i++) {
        var price = state.user.cart[i]['product']['price'];
        debugPrint(price.toString());

        totalPrice += price * state.user.cart[i]['quantity'];
        totalDiscount += totalPrice * 0.1;
      }
      totalPriceWithDiscount = totalPrice - totalDiscount;
    }

    totalPriceWithDiscount = totalPrice - totalDiscount;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        calculateTotal(state);

        return Scaffold(
          appBar: AppBar(
            title: Text('Shopping Cart'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AdressBar(state: state),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.separated(
                      itemCount: _products.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 16.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(_products[index].imageUrl),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _products[index].name,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '\$${_products[index].price}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_products[index].quantity > 1) {
                                              _products[index].quantity--;
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text('${_products[index].quantity}'),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _products[index].quantity++;
                                          });
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      const SizedBox(width: 8.0),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _products.removeAt(index);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Proceed to Checkout'),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Total Discount: \$${totalDiscount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Total Price with Discount: \$${totalPriceWithDiscount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Product2 {
  final String imageUrl;
  final String name;
  final String price;
  int quantity;

  Product2({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

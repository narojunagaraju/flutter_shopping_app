import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    /*
    above cart is shortcut for this
    final cart = Provider
        .of<CartProvider>(context)
        .cart;*/
    print("Cart length is ${cart.length}");
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartItem = cart[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Product',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                                'Are you sure that you want to delete the product ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .removeProduct(cartItem);
                                  Navigator.of(context).pop();
                                  /*
                                  Above line is shortcut for the code below
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .removeProduct(cartItem);*/
                                },
                                child: const Text('Yes',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
                title: Text(
                  cartItem['title'] as String,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text('Size: ${cartItem['size']}'),
              );
            }));
  }
}

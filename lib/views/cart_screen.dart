import 'package:e_commerce_software_persona/model/product_model.dart';
import 'package:e_commerce_software_persona/views/card_entry_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cartIds;
  const CartScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((product) => widget.cartIds.contains(product.id))
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Your cart is empty',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Add items to start shopping',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,

                        itemBuilder: (context, index) {
                          final item = cartProducts[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item.image ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(item.tagline ?? ''),
                                      Text(item.price ?? ''),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.cartIds.remove(item.id);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_outline_outlined,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey.shade600),
                    SizedBox(width: 8),
                    Text(
                      'Lorem Ipsum is simply dummy text ',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (cartProducts.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Add a product to continue'),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: 80,
                          left: 20,
                          right: 20,
                        ),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardEntryScreen(
                        products: cartProducts,
                        cartIds: widget.cartIds,
                      ),
                    ),
                  ).then((_) {
                    setState(() {});
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Text('Checkout', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

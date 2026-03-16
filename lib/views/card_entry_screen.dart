import 'package:e_commerce_software_persona/model/product_model.dart';
import 'package:flutter/material.dart';

class CardEntryScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cartIds;

  const CardEntryScreen({
    super.key,
    required this.products,
    required this.cartIds,
  });

  @override
  State<CardEntryScreen> createState() => _CardEntryScreenState();
}

class _CardEntryScreenState extends State<CardEntryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  double get totalAmount {
    double total = 0;

    for (final product in widget.products) {
      final priceText = (product.price ?? '')
          .replaceAll(RegExp(r'[^0-9.,]'), '')
          .replaceAll(',', '.');

      total += double.tryParse(priceText) ?? 0;
    }

    return total;
  }

  String get currency {
    if (widget.products.isEmpty) {
      return '\$';
    }

    return widget.products.first.currency ?? '\$';
  }

  String get totalText {
    if (totalAmount == 0) {
      return widget.products.fold<String>('', (value, product) {
        if (value.isNotEmpty) {
          return value;
        }

        return product.price ?? '';
      });
    }

    return '$currency ${totalAmount.toStringAsFixed(2)}';
  }

  void completeOrder() {
    if (nameController.text.trim().isEmpty ||
        numberController.text.trim().isEmpty ||
        expiryController.text.trim().isEmpty ||
        cvvController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all card details'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Complete'),
          content: Text('Your order has been placed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                widget.cartIds.clear();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Card',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  'Enter your payment details to finish checkout',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.credit_card, color: Colors.white, size: 30),
                      SizedBox(height: 24),
                      Text(
                        numberController.text.isEmpty
                            ? '**** **** **** 4242'
                            : numberController.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Holder',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                nameController.text.isEmpty
                                    ? 'YOUR NAME'
                                    : nameController.text.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expires',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                expiryController.text.isEmpty
                                    ? 'MM/YY'
                                    : expiryController.text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildField(
                        controller: nameController,
                        label: 'Name on card',
                        hintText: 'John Doe',
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 14),
                      _buildField(
                        controller: numberController,
                        label: 'Card number',
                        hintText: '1234 5678 9012 3456',
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              controller: expiryController,
                              label: 'Expiry date',
                              hintText: 'MM/YY',
                              keyboardType: TextInputType.datetime,
                              onChanged: (_) {
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildField(
                              controller: cvvController,
                              label: 'CVV',
                              hintText: '123',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text('${widget.products.length}'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            totalText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: completeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Complete Payment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_commerce_software_persona/model/product_model.dart';
import 'package:e_commerce_software_persona/views/card_entry_screen.dart';

void main() {
  testWidgets('Card entry screen shows item count and total amount', (
    WidgetTester tester,
  ) async {
    final products = [
      Data(
        id: 1,
        name: 'Persona Phone',
        price: '1299.99',
        currency: '\$',
      ),
      Data(
        id: 2,
        name: 'Persona Tablet',
        price: '499.50',
        currency: '\$',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: CardEntryScreen(products: products, cartIds: {1, 2}),
      ),
    );

    expect(find.text('Add Card'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('\$ 1799.49'), findsOneWidget);
    expect(find.text('Complete Payment'), findsOneWidget);
  });
}

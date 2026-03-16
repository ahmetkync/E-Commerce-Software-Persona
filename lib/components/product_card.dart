import 'package:e_commerce_software_persona/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Data product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: product.id ?? 0,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.vertical(
                    top: Radius.circular(12),
                  ),

                  child: Image.network(product.image ?? ""),
                ),
              ),
            ),

            Text(
              product.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 1),
            Text(
              product.tagline ?? "",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: 1),
            Text(
              product.price ?? 'N/A',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart';

class OrderItem extends StatefulWidget {
  final Order orderItem;

  const OrderItem({super.key, required this.orderItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;

  void toggleIsExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: toggleIsExpanded,
            ),
          ),
          if (_isExpanded)
            Container(
              height: min(widget.orderItem.products.length * 20 + 20, 150),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 10),
              child: ListView(
                  children: widget.orderItem.products
                      .map((product) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${product.quantity}x \$${product.price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ))
                      .toList()),
            )
        ],
      ),
    );
  }
}

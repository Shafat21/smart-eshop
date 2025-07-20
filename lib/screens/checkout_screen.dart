// lib/screens/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../providers/cart_provider.dart';
import '../widgets/app_drawer.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddress = 0;

  @override
  Widget build(BuildContext context) {
    final cartProv = context.watch<CartProvider>();
    final theme    = Theme.of(context);

    // Sample addresses
    final addresses = [
      {
        'label': 'Home',
        'phone': '123‑456‑7890',
        'address': '123 Main Street',
      },
      {
        'label': 'Office',
        'phone': '(342) 452‑2019',
        'address': '220 Montmartre, Paris',
      },
    ];

    final subtotal    = cartProv.total;
    final deliveryFee = 50.0;
    final total       = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Text(
              'Delivery address',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...List.generate(addresses.length, (i) {
              final addr = addresses[i];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Radio<int>(
                      value: i,
                      groupValue: _selectedAddress,
                      onChanged: (v) => setState(() => _selectedAddress = v!),
                      activeColor: theme.colorScheme.primary,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addr['label']!,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(addr['phone']!, style: theme.textTheme.bodyMedium),
                          SizedBox(height: 4),
                          Text(addr['address']!, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: theme.iconTheme.color),
                      onPressed: () {
                        // TODO: Navigate to address edit
                      },
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 24),

            // Billing Information
            Text(
              'Billing information',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildRow('Delivery Fee', '\$${deliveryFee.toStringAsFixed(0)}', theme),
            _buildRow('Subtotal',     '\$${subtotal.toStringAsFixed(0)}', theme),
            Divider(height: 24, thickness: 1, color: theme.dividerColor),
            _buildRow('Total',        '\$${total.toStringAsFixed(0)}', theme, isTotal: true),

            SizedBox(height: 32),

            // Payment Method Icons
            Text(
              'Payment Method',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.apple, size: 32, color: theme.iconTheme.color),
                Icon(Icons.credit_card, size: 32, color: theme.iconTheme.color),
                Icon(Icons.payment, size: 32, color: theme.iconTheme.color),
                Icon(Icons.account_balance_wallet, size: 32, color: theme.iconTheme.color),
              ],
            ),

            SizedBox(height: 32),

            // Swipe for Payment
            Builder(builder: (ctx) {
              return SlideAction(
                innerColor: theme.colorScheme.onPrimary,
                outerColor: theme.colorScheme.primary,
                text: 'Swipe for Payment',
                onSubmit: () {
                  // TODO: implement payment
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text('Payment Completed!')),
                  );
                },
              );
            }),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, ThemeData theme, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal
                  ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                  : theme.textTheme.bodyMedium),
          Text(value,
              style: isTotal
                  ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                  : theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

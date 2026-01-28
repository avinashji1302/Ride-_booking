import 'package:flutter/material.dart';

class PaymentMode extends StatefulWidget {
  final Function(String) onSubmit;

  const PaymentMode({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  String selectedMethod = "Cash"; // default

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Payment Mode",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        _paymentTile("Cash"),
        const Divider(height: 1),
        _paymentTile("Wallet"),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              widget.onSubmit(selectedMethod);
              Navigator.pop(context);
            },
            child: const Text("Continue"),
          ),
        ),
      ],
    );
  }

  Widget _paymentTile(String title) {
    final isSelected = selectedMethod == title;

    return ListTile(
      leading: Icon(
        isSelected
            ? Icons.radio_button_checked
            : Icons.radio_button_off,
        color: isSelected ? Colors.green : Colors.grey,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        setState(() {
          selectedMethod = title;
        });
      },
    );
  }
}

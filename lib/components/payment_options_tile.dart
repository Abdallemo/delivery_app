import 'package:deliver/components/my_button.dart';
import 'package:flutter/material.dart';

class PaymentOptionsTile extends StatelessWidget {
  final List<String> paymentOptions;
  final String? selectedPaymentOption;
  final ValueChanged<String?> onPaymentOptionChanged;
  final VoidCallback onProceed;

  PaymentOptionsTile({
    Key? key,
    required this.paymentOptions,
    required this.selectedPaymentOption,
    required this.onPaymentOptionChanged,
    required this.onProceed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Payment Options",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1),
        ...paymentOptions.map((option) {
          return RadioListTile<String>(
            controlAffinity: ListTileControlAffinity.trailing,
            title: Row(
              children: [
                Icon(
                  option == 'MasterCard'
                      ? Icons.credit_card
                      : Icons.attach_money_rounded,
                  size: 30,
                ),
                SizedBox(width: 5,),
                Text(option),
              ],
            ),
            value: option,
            groupValue: selectedPaymentOption,
            onChanged: (value) {
              onPaymentOptionChanged(value);
            },
          );
        }).toList(),
        SizedBox(height: 20),
        Center(
          child: MyButton(onTap: onProceed, text: "Proceed")
        ),
      ],
    );
  }
}


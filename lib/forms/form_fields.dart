import 'package:flutter/material.dart';

class FormFields {
  static final RegExp numberRegex =
      RegExp(r'^(0(\.[0-9]+)?)|([1-9][0-9]*(\.[0-9]+)?)$');

  static getTotalSumField(TextEditingController controller) => Padding(
        padding: const EdgeInsets.all(16.00),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'ex. 100.00',
            helperText: 'Total Sum *',
          ),
          controller: controller,
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !numberRegex.hasMatch(value)) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );

  static getPaidSumField(TextEditingController controller) => Padding(
        padding: const EdgeInsets.all(16.00),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'ex. 50.00',
            helperText: 'Paid Sum',
            counterText: 'Less than Total Sum, can be empty',
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return null;
            } else if (numberRegex.hasMatch(value)) {
              return null;
            }
            return 'Please enter a valid number';
          },
        ),
      );

  static getReasonField(TextEditingController controller) => Padding(
        padding: const EdgeInsets.all(16.00),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'ex. Parked on sidewalk',
            helperText: 'Reason *',
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );

  static getAddressField(TextEditingController controller) => Padding(
        padding: const EdgeInsets.all(16.00),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'ex. str. Moților nr.3, 400001 Cluj-Napoca, Romania',
            helperText: 'Address *',
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );

  static getIBANField(TextEditingController controller) => Padding(
        padding: const EdgeInsets.all(16.00),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'ex. RO1234567890XXXX',
            helperText: 'IBAN',
          ),
          controller: controller,
          validator: (value) {
            return null;
          },
        ),
      );
}

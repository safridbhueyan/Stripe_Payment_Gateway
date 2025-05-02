import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/const.dart'; 

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();

  // Main entry point to make a payment
  Future<void> makePayment() async {
    try {
      String? clientSecret = await _createPaymentIntent(10, "usd");
      if (clientSecret != null) {
        debugPrint("Client secret: $clientSecret");
        await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "safrid bhueyan"
        ));
        await _processPayment();
      } else {
        debugPrint("Failed to create PaymentIntent.");
      }
    } catch (e) {
      debugPrint("makePayment error: ${e.toString()}");
    }
  }

  // Creates a PaymentIntent on Stripe
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization': 'Bearer $stripeSecretekey', 
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "amount": _calculatedAmount(amount),
          "currency": currency,
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['client_secret']; 
      } else {
        debugPrint("Stripe API error: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Stripe request error: $e");
      return null;
    }
  }
 Future<void> _processPayment()async{
  try{
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
  }catch(e){
    print(e);
  }
 }
  // Converts amount to cents
  String _calculatedAmount(int amount) {
    final calculatedAmount = amount * 100; 
    return calculatedAmount.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:stripe_payment/services/stripe_services.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: (){
            StripeServices.instance.makePayment();
          }, child: Text("Stripe payment")),
        ),
      ),
    );
  }
}
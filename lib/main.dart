import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/const.dart';
import 'package:stripe_payment/home.dart';

void main() async{
  await _setup();
  runApp(const MyApp());
}
Future<void> _setup()async{
 await WidgetsFlutterBinding.ensureInitialized();
 String stripePublishableKey;
//  Stripe.publishableKey = stripePublishableKey;
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Home(),
     
    );
  }
}


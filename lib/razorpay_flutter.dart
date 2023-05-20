import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final razorpay = Razorpay();
  final _userName = TextEditingController();

  var Textfeild = "";

  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      Fluttertoast.showToast(
          msg: "SUCCESS: " + response.paymentId!, timeInSecForIosWeb: 4);
    });
  }

  void handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      Fluttertoast.showToast(
          msg: "ERROR: " + response.code.toString() + " - " + response.message!,
          timeInSecForIosWeb: 4);
    });
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void startPayment() {

    final options = {
      'key': 'rzp_test_zPZbyKzTSLfL4E',
      'amount': 1000, // amount in paisa
      'name': "$Textfeild",
      'description': 'Test payment',
      'prefill': {'contact': '7352120518', 'email': 'priencraj32@gmail.com'},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _userName,

              ),
            ),

            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  startPayment();
                  String text = _userName.text;
                  setState(() {
                  Textfeild = text;

                  });
                },
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

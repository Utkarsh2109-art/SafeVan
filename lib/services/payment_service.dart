import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {

  final Razorpay _razorpay = Razorpay();

  void initialize({

    required Function() onSuccess,

  }) {

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,

          (PaymentSuccessResponse response) {

        onSuccess();
      },
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,

          (PaymentFailureResponse response) {

        print("PAYMENT FAILED");
      },
    );

    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,

          (ExternalWalletResponse response) {

        print("EXTERNAL WALLET");
      },
    );
  }

  void openCheckout() {

    var options = {

      'key': 'rzp_live_Styo9Sh4bkx5Op',

      'amount': 50000,

      'name': 'SafeVan',

      'description': 'Van Seat Booking',

      'prefill': {

        'contact': '9876543210',

        'email': 'test@gmail.com',
      }
    };

    _razorpay.open(options);
  }

  void dispose() {

    _razorpay.clear();
  }
}
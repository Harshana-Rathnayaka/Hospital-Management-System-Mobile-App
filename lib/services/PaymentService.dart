import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  String paymentId;
  StripeTransactionResponse({this.message, this.success, this.paymentId});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = 'sk_test_TeymjdiMfBgX3S3Y4aH02mHJ00iHAcAqO7';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_N8TwbIpKjy2iARMwNS5ciGAX00qpc7eyeq",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency, String paymentFor}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency, paymentFor);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful!',
            success: true,
            paymentId: paymentMethod.id);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed!', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed: ${err.toString()}',
        success: false,
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled!';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency, String paymentFor) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'description': 'Payment for the $paymentFor',
        'payment_method_types[]': 'card'
      };

      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);

      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}

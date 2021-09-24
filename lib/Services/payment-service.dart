import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

// class StripeTransactionResponse {
//   String message;
//   bool success;
//   StripeTransactionResponse({this.message, this.success});
// }
//
// class StripeService {
//   static String apiBase = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = apiBase+'/payment_intents';
//   // static String secret = 'sk_test_51JclJoSC5iM4oFkgpFF9XppXYIDVEcn6J6GSIeeNvRWSCic
//   // BmVKFjhYLvqJL5aFacb2T9Y9b6su5ozbFwPnwHwvB00GHiUsSA5';//////////// my acc
//   static String secret = 'sk_test_51JclJoSC5iM4oFkgpFF9XppXYIDVEcn6J6GSIeeNvRWSCicBmVKFjhYLvqJL5aFacb2T9Y9b6su5ozbFwPnwHwvB00GHiUsSA5';
//   static String pubKey;
//   static Map<String, String> headers = {
//     'Authorization': 'Bearer ${StripeService.secret}',
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };
//   static init() {
//     StripePayment.setOptions(StripeOptions(
//         // publishableKey: "pk_test_51JclJoSC5iM4oFkgvuhaYdwMPcGQYjxkCrTVYIndQIQOnWgwe
//       // pIQG2k9oMB8MZtWgzj00oT5RN3ZCGULmugRpsac00ChgVm6O1",/////////////// my acc
//         publishableKey: pubKey,
//         merchantId: "Test",
//         androidPayMode: 'test'));
//   }
//
//   static Future<StripeTransactionResponse> payViaExistingCard(
//       {String amount, String currency, CreditCard card}) async {
//     try {
//       var paymentMethod = await StripePayment.createPaymentMethod(
//           PaymentMethodRequest(card: card));
//       var paymentIntent =
//       await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: paymentIntent[secret],
//           paymentMethodId: paymentMethod.id));
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (err) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (err) {
//       return new StripeTransactionResponse(
//           message: 'Transaction failed: ${err.toString()}', success: false);
//     }
//   }
//
//   static Future<StripeTransactionResponse> payWithNewCard(
//       {String amount, String currency}) async {
//     try {
//       var paymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());
//       var paymentIntent =
//       await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: paymentIntent['client_secret'],
//           paymentMethodId: paymentMethod.id));
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (err) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (err) {
//       return new StripeTransactionResponse(
//           message: 'Transaction failed: ${err.toString()}', success: false);
//     }
//   }
//
//   static getPlatformExceptionErrorResult(err) {
//     String message = 'Something went wrong';
//     if (err.code == 'cancelled') {
//       message = 'Transaction cancelled';
//     }
//
//     return new StripeTransactionResponse(message: message, success: false);
//   }
//
//   static Future<Map<String, dynamic>> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       var url = Uri.parse(StripeService.paymentApiUrl);
//
//       var response = await http.post(url, body: body, headers: StripeService.headers);
//       print(response.body);
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//     return null;
//   }
// }

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret;

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init(String pub, String key) {
    secret = key;
    StripePayment.setOptions(StripeOptions(
        publishableKey:pub,
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  //existing cards
  static Future<StripeTransactionResponse> payViaExistingCard(
      {String amount, String currency, CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(PaymentMethodRequest(card: card));
      var paymentIntent = await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(clientSecret: paymentIntent['client_secret'], paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
      var paymentIntent = await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(clientSecret: paymentIntent['client_secret'], paymentMethodId: paymentMethod.id)
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var url = Uri.parse(StripeService.paymentApiUrl);
      var response = await http.post(url, body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}
class PaymentInfo {
  int bookingId;
  int amount;
  String currency;
  String stripePublicKey;
  String clientSecret;

  PaymentInfo(
      {this.bookingId,
        this.amount,
        this.currency,
        this.stripePublicKey,
        this.clientSecret});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    amount = json['amount'];
    currency = json['currency'];
    stripePublicKey = json['stripePublicKey'];
    clientSecret = json['clientSecret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['stripePublicKey'] = this.stripePublicKey;
    data['clientSecret'] = this.clientSecret;
    return data;
  }
}
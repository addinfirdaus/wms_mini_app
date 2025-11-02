extension DateTimeExt on DateTime {
  String toShortDate() {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
  }

  bool get isExpired => isBefore(DateTime.now());
  bool get isNearExpiry =>
      isBefore(DateTime.now().add(const Duration(days: 30)));
}

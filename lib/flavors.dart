enum Flavor {
  CONSUMER,
  AGENT,
  MERCHANT,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.CONSUMER:
        return 'Tara Consumer';
      case Flavor.AGENT:
        return 'Tara Agent';
      case Flavor.MERCHANT:
        return 'Tara Merchant';
      default:
        return 'Tara';
    }
  }

}

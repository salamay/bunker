class NetworkModel{
  String chain_name;
  String image_url;
  String chain_symbol;
  String chain_currency;
  int chain_id;
  String unit;
  String nativeCoinId;
  String scanUrl;
  String scanName;
  double minimumCurrency;

  NetworkModel({
    required this.chain_name,
    required this.image_url,
    required this.chain_id,
    required this.chain_symbol,
    required this.chain_currency,
    required this.unit,
    required this.nativeCoinId,
    required this.scanUrl,
    required this.scanName,
    required this.minimumCurrency
  });
}
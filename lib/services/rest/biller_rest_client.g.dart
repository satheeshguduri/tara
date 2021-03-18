// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biller_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BillerRestClient implements BillerRestClient {
  _BillerRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://107.20.4.43/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BillProductsResponse> getBillProducts(
      token, billProductRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(billProductRequest, 'billProductRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(billProductRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/ayopop/partner/products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BillProductsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BillDetailsResponse> payBill(token, billProductRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(billProductRequest, 'billProductRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(billProductRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/ayopop/bill/payment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BillDetailsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BillDetailsResponse> checkBill(token, billProductRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(billProductRequest, 'billProductRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(billProductRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/ayopop/bill/check',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BillDetailsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BillDetailsResponse> getBillStatus(token, billProductRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(billProductRequest, 'billProductRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(billProductRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/ayopop/bill/status',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BillDetailsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BalanceDataResponse> getBalance(token, billProductRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(billProductRequest, 'billProductRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(billProductRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/ayopop/partner/balance',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BalanceDataResponse.fromJson(_result.data);
    return value;
  }
}

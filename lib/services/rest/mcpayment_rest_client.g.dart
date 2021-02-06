// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcpayment_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _McPaymentRestClient implements McPaymentRestClient {
  _McPaymentRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://107.20.4.43:9005/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<CardData>> getCards(token, customerId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'v0.1/mcpayment/detail/card/$customerId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => CardData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CreateCardOrPaymentResponse> createCardOrPay(
      token, createCardOrPayRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(
        createCardOrPayRequest, 'createCardOrPayRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createCardOrPayRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/mcpayment/request/tokenization',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateCardOrPaymentResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateCardOrPaymentResponse> payWithCard(token, payCardRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(payCardRequest, 'payCardRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(payCardRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/mcpayment/request/payment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateCardOrPaymentResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> deleteCard(token, cardToken) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(cardToken, 'cardToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/mcpayment/delete/token/{registerId}',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }
}

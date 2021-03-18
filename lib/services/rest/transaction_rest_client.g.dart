// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TransactionRestClient implements TransactionRestClient {
  _TransactionRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://107.20.4.43:9000/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<PaymentResponse> sendMoney(token, transactionModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(transactionModel, 'transactionModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(transactionModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/account',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PaymentResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> updateSendRequest(
      token, transactionId, transactionModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(transactionId, 'transactionId');
    ArgumentError.checkNotNull(transactionModel, 'transactionModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(transactionModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/account/$transactionId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }
}

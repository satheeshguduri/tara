// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://107.20.4.43:9001/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BaseResponse> getOTP(authRequestWithData) async {
    ArgumentError.checkNotNull(authRequestWithData, 'authRequestWithData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authRequestWithData?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('v1/tara/auth/otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> validateOtp(authRequestWithData) async {
    ArgumentError.checkNotNull(authRequestWithData, 'authRequestWithData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authRequestWithData?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/auth/otp/validate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AuthResponse> login(loginRequest) async {
    ArgumentError.checkNotNull(loginRequest, 'loginRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/auth/validate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AuthResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AuthResponse> signUp(signUpRequest) async {
    ArgumentError.checkNotNull(signUpRequest, 'signUpRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signUpRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('v1/tara/auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AuthResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> updateProfile(token, updateProfileRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(updateProfileRequest, 'updateProfileRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateProfileRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/crm/customer',
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

  @override
  Future<Store> createStore(token, store) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(store, 'store');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(store?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Store.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> deleteStore(token, id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = id;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<Store> updateStore(token, store) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(store, 'store');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(store?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Store.fromJson(_result.data);
    return value;
  }

  @override
  Future<Store> setStatus(token, storeId, status) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(storeId, 'storeId');
    ArgumentError.checkNotNull(status, 'status');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = storeId;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Store.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Store>> getAllStores(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Store.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Store> getStore(token, storeId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(storeId, 'storeId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = storeId;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Store.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Order>> getConsumerOrders(token, consumerId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(consumerId, 'consumerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'v0.1/tara/erp/consumer/$consumerId/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Order>> getMerchantOrders(token, merchantId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(merchantId, 'merchantId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        'v0.1/tara/erp/merchant/$merchantId/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Order> createOrder(token, order, merchantId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(order, 'order');
    ArgumentError.checkNotNull(merchantId, 'merchantId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(order?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> deleteOrder(token, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = orderId;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> updateOrder(token, order, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(order, 'order');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(order?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order/$orderId}',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> findByTransactionId(token, transactionId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(transactionId, 'transactionId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = transactionId;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> findOrderByMerchantId(token, merchantId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(merchantId, 'merchantId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = merchantId;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> getOrderByOrderId(token, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = orderId;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Order>> getOrdersByConsumerId(token, consumerId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(consumerId, 'consumerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = consumerId;
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Order>> getOrdersByMerchantId(token, merchantId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(merchantId, 'merchantId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = merchantId;
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Order>> findAllByOrderId(token, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = orderId;
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Catalogue>> getAll(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Catalogue.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Catalogue> getCatalogueById(token, id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = id;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Catalogue.fromJson(_result.data);
    return value;
  }

  @override
  Future<Catalogue> getOneById(token, id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = id;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Catalogue.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> removeCatalogue(token, Id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(Id, 'Id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = Id;
    await _dio.request<void>('v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<Catalogue> saveCatalogue(token, catalogue) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogue, 'catalogue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(catalogue?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Catalogue.fromJson(_result.data);
    return value;
  }

  @override
  Future<Catalogue> updateCatalogue(token, catalogue, id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogue, 'catalogue');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(catalogue?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Catalogue.fromJson(_result.data);
    return value;
  }
}

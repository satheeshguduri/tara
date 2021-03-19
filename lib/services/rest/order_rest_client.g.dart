// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OrderRestClient implements OrderRestClient {
  _OrderRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://107.20.4.43:9002/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Store> createStore(token, store) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(store, 'store');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(store?.toJson() ?? <String, dynamic>{});
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
  Future<Owner> createOwner(token, owner) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(owner, 'owner');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(owner?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/owner',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Owner.fromJson(_result.data);
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
  Future<List<StoreTypeModel>> getStoreTypes(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/storetype',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => StoreTypeModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<OrderResponse> createOrder(token, order) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(order, 'order');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(order?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderResponse> updateOrder(token, order, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(order, 'order');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(order?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order/$orderId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderResponse> getOrderByOrderId(token, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order/$orderId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<OrderResponse>> getOrdersByConsumerId(token, consumerId) async {
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
        .map((dynamic i) => OrderResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<OrderResponse>> getOrdersByMerchantId(token, merchantId) async {
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
        .map((dynamic i) => OrderResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<BannerData>> getBanners(token, queries) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/banner',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => BannerData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Item>> getItemsByCatalogue(token, queries) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/item/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Item.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Category>> getCategories(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Category.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Catalogue>> getCatalogues(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/catalogue',
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
  Future<Catalogue> saveCatalogue(token, catalogue) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogue, 'catalogue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(catalogue?.toJson() ?? <String, dynamic>{});
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
  Future<Catalogue> updateCatalogue(token, catalogue) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogue, 'catalogue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(catalogue?.toJson() ?? <String, dynamic>{});
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
  Future<AddProductsResponse> addProducts(token, items) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(items, 'items');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = items.map((e) => e.toJson()).toList();
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/item',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddProductsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetProductResponse> getProducts(token, page, size) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(size, 'size');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page, r'size': size};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/item',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdateProductResponse> updateProduct(token, items) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(items, 'items');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = items.map((e) => e.toJson()).toList();
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/item',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdateProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteProductResponse> deleteProducts(token, itemIds) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(itemIds, 'itemIds');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = itemIds;
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/item',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> favoriteItem(token, requestModel) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/item/favourite',
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
  Future<BaseResponse> unFavoriteItem(
      token, catalogueId, itemId, customerId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogueId, 'catalogueId');
    ArgumentError.checkNotNull(itemId, 'itemId');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'catalogueId': catalogueId,
      r'itemId': itemId,
      r'customerId': customerId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/item/favourite',
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

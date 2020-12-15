import 'package:dartz/dartz.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/repositories/catalogue_service_repository.dart';
import 'package:tara_app/services/error/failure.dart';

class CatalogueServiceRepositoryImpl extends CatalogueServiceRepository{
  @override
  Future<Either<Failure, List<Catalogue>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Catalogue>> getCatalogueById(double id) {
    // TODO: implement getCatalogueById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Catalogue>> getOneById(double id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeCatalogue(double id) {
    // TODO: implement removeCatalogue
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Catalogue>> saveCatalogue(Catalogue catalogue) {
    // TODO: implement saveCatalogue
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Catalogue>> updateCatalogue(Catalogue catalogue, double id) {
    // TODO: implement updateCatalogue
    throw UnimplementedError();
  }

}
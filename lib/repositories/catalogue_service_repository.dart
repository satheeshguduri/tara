/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class CatalogueServiceRepository {
  Future<Either<Failure,Catalogue>> saveCatalogue(Catalogue catalogue);
  Future<Either<Failure,Catalogue>> updateCatalogue(Catalogue catalogue, double id);
  Future<Either<Failure,void>> removeCatalogue(double id);
  Future<Either<Failure,Catalogue>> getCatalogueById(double id);
  Future<Either<Failure,List<Catalogue>>> getAll();
  Future<Either<Failure,Catalogue>> getOneById(double id);
 





}


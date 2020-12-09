/*
*  injector.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injector.config.dart';

var getIt = GetIt.I;

@InjectableInit(
initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true
)
void initInjection(){
  getIt.init();
}
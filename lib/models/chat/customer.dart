/*
*  customer.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'order.dart';

class Customer {
     String firstName;
     String lastName;
     num rdbmsId;
    //wrt TB-59
     List<Order> orders = null;
}

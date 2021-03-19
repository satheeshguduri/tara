import 'package:get/get.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';

//Todo add search functionality
class CategorySheetController extends GetxController {
  var selectedCategories = {}.obs;
  var duplicateMap = {}.obs;

  CategorySheetController(List<Category> previouslySelected) {
    // print("Previously selected ${previouslySelected[0].name}");
    StoreController storeController = Get.find();
    storeController.categoryList.forEach((e) {
      print(e.name);
      selectedCategories.putIfAbsent(
        e,
        () {
          print("somethih ${previouslySelected.contains(e)}");
          if (previouslySelected.contains(e)) {
            return true;
          } else {
            return false;
          }
        },
      );
    });
    print(selectedCategories);
    duplicateMap = selectedCategories;
  }

  @override
  void onInit() {
    super.onInit();
    selectedCategories.listen((s) {
      print("slected $s");
    });
  }

  negativeCategory(Category c) {
    //category selected or unselected
    selectedCategories[c] = !selectedCategories[c];
  }

  //save categories and return to the navigator for rendering it to the UI
  save() {
    List<Category> s = selectedCategories.keys
        .where((element) => selectedCategories[element])
        .cast<Category>()
        .toList();

    print("somet $s");
    Get.back(result: s.isNotEmpty ? s : null);
  }

  filter(String query) {
    // duplicateMap.clear();

    // print(query);
    Map map = {};
    selectedCategories.keys
        .where((element) => element.name.toLowerCase().contains(query))
        .toList()
        .forEach((e) {
      // print(e);
      map.putIfAbsent(e, () => selectedCategories[e]);
    });

    duplicateMap
      ..clear()
      ..addAll(map);
  }
}

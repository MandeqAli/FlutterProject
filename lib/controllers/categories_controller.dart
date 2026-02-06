import 'package:get/get.dart';
import '../models/category_item.dart';
import '../pages/category_details_page.dart';
import '../services/api.dart';

class CategoriesController extends GetxController {
  final RxInt selectedTab = 1.obs;

  final RxBool loading = false.obs;
  final RxString error = "".obs;

  final RxList<CategoryItem> categories = <CategoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      loading.value = true;
      error.value = "";
      final res = await Api.get("/api/products");
      final list = (res["data"] as List? ?? []);
      categories.assignAll(list.map((e) => CategoryItem.fromJson(e)).toList());
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  void toggleFav(CategoryItem item) => item.isFav.value = !item.isFav.value;

  void openDetails(CategoryItem item) {
    Get.to(() => CategoryDetailsPage(item: item));
  }

  void onTabChange(int index) => selectedTab.value = index;
}

import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/consts/lists.dart';
import 'package:userside_ecommerce/controller/product_controller.dart';
import 'package:userside_ecommerce/views/category_screen/category_details.dart';
import 'package:userside_ecommerce/widgets_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            categories,
            style: TextStyle(fontFamily: bold, color: whiteColor),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await controller.getSubCategories(categoriesList[index]);
                  Get.to(() => CategoryDetails(title: categoriesList[index]));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        categoryImages[index],
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            categoriesList[index],
                            style: const TextStyle(color: darkFontGrey),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

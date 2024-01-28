import 'package:get/get.dart';
import 'package:userside_ecommerce/consts/consts.dart';
import 'package:userside_ecommerce/controller/home_controller.dart';
import 'package:userside_ecommerce/views/cart_screen/cart_screen.dart';
import 'package:userside_ecommerce/views/category_screen/category_screen.dart';
import 'package:userside_ecommerce/views/home_screen/home_screen.dart';
import 'package:userside_ecommerce/views/profile_screen/profile_screen.dart';
import 'package:userside_ecommerce/widgets_common/exit_dialogbox.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //navbar controller
    HomeController controller = Get.put(HomeController());

    //navbar items
    List<BottomNavigationBarItem> navbarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    // nav body
    List<Widget> navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context),
        );
        return false;
      },
      child: Scaffold(
        body: Obx(
          () => Container(
            child: Expanded(child: navBody[controller.currentNavIndex.value]),
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedIconTheme: const IconThemeData(color: redColor),
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: bold),
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            items: navbarItems,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}

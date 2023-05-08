import 'package:get/get.dart';

import '../../middlewares/auth_middleware.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/sales_summary/bindings/sales_summary_binding.dart';
import '../modules/sales_summary/views/sales_summary_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => TransactionsView(),
      binding: TransactionsBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.SALES_SUMMARY,
      page: () => SalesSummaryView(),
      transition: Transition.noTransition,
      middlewares: [
        AuthMiddleware(),
      ],
      binding: SalesSummaryBinding(),
    ),
  ];
}

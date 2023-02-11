import 'package:share_cost_app/views/login_view.dart';

class Routes {

  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String createExpense = '/create-expense';

  static final routes = {
    home: (context) => const LoginView(),
  };
}
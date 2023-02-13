import 'package:share_cost_app/views/create_expense_view.dart';
import 'package:share_cost_app/views/dashboard_view.dart';
import 'package:share_cost_app/views/home_view.dart';
import 'package:share_cost_app/views/login_view.dart';
import 'package:share_cost_app/views/signup_view.dart';

class Routes {

  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String createExpense = '/create-expense';

  static final routes = {
    home: (context) => const HomeView(),
    login: (context) => const LoginView(),
    signup: (context) => const SignupView(),
    dashboard: (context) => const DashboardView(),
    createExpense: (context) => const CreateExpenseView(),
  };
}
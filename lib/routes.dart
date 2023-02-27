import 'package:share_cost_app/views/create_expense_view.dart';
import 'package:share_cost_app/views/groups/group_view.dart';
import 'package:share_cost_app/views/groups/create_group_view.dart';
import 'package:share_cost_app/views/groups/group_list_view.dart';
import 'package:share_cost_app/views/home_view.dart';
import 'package:share_cost_app/views/login_view.dart';
import 'package:share_cost_app/views/signup_view.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String group = '/group';
  static const String createExpense = '/create-expense';
  static const String groups = '/groups';
  static const String createGroup = '/groups/create';

  static final routes = {
    home: (context) => const HomeView(),
    login: (context) => const LoginView(),
    signup: (context) => const SignupView(),
    group: (context) => const GroupView(),
    createExpense: (context) => const CreateExpenseView(),
    groups: (context) => const GroupListView(),
    createGroup: (context) => const CreateGroupView(),
  };
}

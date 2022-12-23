import 'package:e_book_app/index.dart';

class AppLeadingButton extends StatelessWidget {
  const AppLeadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconWidget(
      icon: Icons.arrow_back,
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}

import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/app/application/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String routeName = 'setting_page';
  static const String routePath = '/setting_page';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const SettingsPage(),
  );

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final _model = <SettingsModel>[];

  @override
  void initState() {
    _model.addAll([
      // SettingsModel(name: 'Favorite', icon: Icons.favorite_border),
      // SettingsModel(name: 'Downloads', icon: Icons.download),
      SettingsModel(
        name: 'Profile',
        icon: Icons.person,
        onTap: () => GoRouter.of(context).pushNamed(
          ProfilePage.routeName,
        ),
      ),
      SettingsModel(name: 'About', icon: Icons.error),
      // SettingsModel(name: 'Liences', icon: Icons.description),
    ]);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  final bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) => previous.theme != current.theme,
        builder: (context, state) {
          return Column(
            children: List.generate(
              _model.length,
              (index) {
                if (index == 0) {
                  return Column(
                    children: [
                      SwitchListTile.adaptive(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                        value: state.theme == ThemeMode.dark ? true : false,
                        onChanged: (value) {
                          BlocProvider.of<ThemeBloc>(context).add(
                            OnThemeChanged(
                              value ? ThemeMode.dark : ThemeMode.light,
                            ),
                          );
                        },
                        title: Text(
                          'Enable Dark Mode',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      _CustomSettingsButton(_model[index]),
                    ],
                  );
                }
                return _CustomSettingsButton(_model[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _CustomSettingsButton extends StatelessWidget {
  const _CustomSettingsButton(this.model);

  final SettingsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            model.icon,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          title: Text(
            model.name,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onTap: model.onTap,
        ),
        const Divider(),
      ],
    );
  }
}

class SettingsModel {
  SettingsModel({
    required this.name,
    required this.icon,
    this.onTap,
  });

  final String name;
  final IconData icon;
  final VoidCallback? onTap;
}

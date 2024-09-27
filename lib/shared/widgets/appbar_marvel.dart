import 'package:flutter/material.dart';

class AppBarMarvel extends StatelessWidget implements PreferredSizeWidget {
  final bool useBackButton;
  const AppBarMarvel({
    super.key,
    this.useBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: useBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: useBackButton ?  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Image.asset(
            'assets/images/marvel_logo1.png',
            height: kToolbarHeight - 10,
          ),
          const Spacer(flex: 2),
        ],
      ) : Center(
        child: Image.asset(
          'assets/images/marvel_logo1.png',
          height: kToolbarHeight - 10,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

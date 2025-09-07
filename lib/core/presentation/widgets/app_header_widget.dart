import 'package:flutter/material.dart';

/// Widget d'en-tête réutilisable pour toutes les pages de l'application
class AppHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  const AppHeaderWidget({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.8),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading ?? 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/ftc_logo.png',
            width: 32,
            height: 32,
            errorBuilder: (context, error, stackTrace) {
              // Fallback icon if logo not found
              return const Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 32,
              );
            },
          ),
        ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

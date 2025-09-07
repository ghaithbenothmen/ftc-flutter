import 'package:flutter/material.dart';

/// Widget de fond réutilisable avec image et dégradé moderne
class AppBackgroundWidget extends StatelessWidget {
  final Widget child;

  const AppBackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-ftc.jpg'),
          fit: BoxFit.cover,
          opacity: 0.3, // Transparence de l'image
          onError: (error, stackTrace) {
            // Fallback si l'image n'est pas trouvée
            print('Background image not found: $error');
          },
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.grey.shade900.withOpacity(0.8),
            Colors.red.shade900.withOpacity(0.3),
            Colors.black.withOpacity(0.9),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: child,
    );
  }
}

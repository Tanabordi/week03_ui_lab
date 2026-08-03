import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;
  final int postsCount;
  final int followersCount;
  final int followingCount;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });

  /// Helper method to extract the first letter of the first and last name 
  /// to use as a fallback when the avatarUrl is null.
  String get _initials {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // Read the current theme for typography and color scheme (NO hardcoded colors)
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      // Material 3 defaults to 1.0 elevation for elevated cards, 
      // but explicitly setting it fulfills the elevation requirement.
      elevation: 1.0, 
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Proper 16px padding inside the card
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- 1. User Avatar ---
            CircleAvatar(
              radius: 32,
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: avatarUrl == null ? Text(_initials) : null,
            ),
            const SizedBox(height: 8), // 8px spacing between elements

            // --- 2. Username ---
            Text(
              name,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),

            // --- 3. Email ---
            Text(
              email,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),

            // --- 4. Action Buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {},
                  child: const Text('Follow'),
                ),
                const SizedBox(width: 8), // 8px spacing between side-by-side elements
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Message'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- 5. User Stats (Posts, Followers, Following) ---
            Padding(
              // Adding slightly extra padding for the stats to visually separate it from the buttons
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('Posts', postsCount, textTheme, colorScheme),
                  _buildStatColumn('Followers', followersCount, textTheme, colorScheme),
                  _buildStatColumn('Following', followingCount, textTheme, colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget to build the individual stats in a Column (Number + Label)
  Widget _buildStatColumn(
    String label, 
    int count, 
    TextTheme textTheme, 
    ColorScheme colorScheme,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8), // 8px spacing between number and label
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

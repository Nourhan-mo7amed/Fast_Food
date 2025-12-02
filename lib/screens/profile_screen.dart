import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: themeNotifier.isDark
            ? Colors.grey.shade900
            : Colors.white,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: themeNotifier.isDark
              ? Colors.grey.shade900
              : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Picture
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 3),
                      color: Colors.orange.shade50,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // User Name
              Text(
                'Nour Mohamed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              // Email
              Text(
                'nour@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: themeNotifier.isDark
                      ? Colors.grey.shade400
                      : Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              // Profile Options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.location_on_outlined,
                      title: 'My Addresses',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.receipt_long_outlined,
                      title: 'Order History',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.favorite_border,
                      title: 'Favorites',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.payment_outlined,
                      title: 'Payment Methods',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: themeNotifier.isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: themeNotifier.isDark
              ? Colors.grey.shade700
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: themeNotifier.isDark ? Colors.black26 : Colors.grey.shade100,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.orange, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: themeNotifier.isDark ? Colors.white : Colors.black,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: themeNotifier.isDark ? Colors.grey.shade400 : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}

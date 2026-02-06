import 'package:flutter/material.dart';
import '../models/profileUserModel.dart';
import '../service/profile_servicesAPI.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  bool loading = true;

  int _currentIndex = 3; // Profile tab selected by default

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    user = await ApiService.getUser(widget.userId);
    if (user != null) {
      _nameController.text = user!.name;
      _emailController.text = user!.email;
      _phoneController.text = user!.phone ?? '';
    }
    setState(() {
      loading = false;
    });
  }

  void updateUser() async {
    if (user != null) {
      final updatedUser = User(
        id: user!.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );
      final result = await ApiService.updateUser(updatedUser);
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Updated!')),
        );
      }
    }
  }

  // Navigation handler
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/categories');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/products');
    } else if (index == 3) {
      // Already on profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name')),
                  TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email')),
                  TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: updateUser, child: const Text('Update'))
                ],
              ),
            ),

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

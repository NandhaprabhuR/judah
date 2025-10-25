import 'package:flutter/material.dart';
// Make sure these imports match your project structure
import 'package:judah/screens/setup_location_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

class SetupProfileView extends StatefulWidget {
  const SetupProfileView({super.key});

  @override
  State<SetupProfileView> createState() => _SetupProfileViewState();
}

class _SetupProfileViewState extends State<SetupProfileView> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Fill Your Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Image
            Stack(
              children: [
                // Image Placeholder
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cardBackground,
                    // You would use your Image.asset or Image.network here
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://placehold.co/400x400/E6F7EB/00B14F?text=Profile'),
                    ),
                  ),
                ),
                // Edit Button
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit,
                          color: AppColors.white, size: 20),
                      onPressed: () {
                        // TODO: Handle image pick
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Form Fields
            TextFormField(
              decoration: const InputDecoration(hintText: "Full Name"),
              initialValue: "Andrew Ainsley",
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(hintText: "Nickname"),
              initialValue: "Andrew",
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Date of Birth",
                suffixIcon:
                Icon(Icons.calendar_today, color: AppColors.textFaded),
              ),
              initialValue: "12/27/1995",
              readOnly: true,
              onTap: () {
                // TODO: Show Date Picker
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Email",
                suffixIcon: Icon(Icons.email_outlined, color: AppColors.textFaded),
              ),
              initialValue: "andrew_ainsley@yourdomain.com",
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "+1 000 000 000",
                prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 10, 0),
                  child: Text("🇺🇸", style: TextStyle(fontSize: 24)),
                ),
              ),
              initialValue: "+1 111 467 378 399",
            ),
            const SizedBox(height: 20),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              value: _selectedGender,
              hint: const Text("Gender"),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline, color: AppColors.textFaded),
              ),
              items: ["Male", "Female", "Other"]
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 40),

            // Continue Button
            PrimaryButton(
              text: "Continue",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SetLocationView()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:blueberry_flutter_template/feature/match/widget/ImageBlurEffect.dart';
import 'package:blueberry_flutter_template/feature/match/widget/MatchFilterOptionWidget.dart';
import 'package:blueberry_flutter_template/feature/match/widget/PetBackgroundImage.dart';
import 'package:blueberry_flutter_template/feature/match/widget/ProfileInfoRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:blueberry_flutter_template/model/PetProfileModel.dart';
import '../../utils/AppStrings.dart';

///  ProfileScreen - ProfileDetail 스크린으로 대체할 임시 화면
///  완성 8월 18일 상현

class ProfileScreen extends StatelessWidget {
  final PetProfileModel petProfile;

  const ProfileScreen({super.key, required this.petProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PetBackgroundImage(
            imageUrl: petProfile.imageUrl,
            petId: petProfile.petID,
          ),
          const ImageBlurEffect(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(context),
                const Spacer(),
                _buildProfileInfoCard(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MatchFilterOptionWidget(petProfile: petProfile),
        ],
      ),
    );
  }

  Widget _buildProfileInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 8),
          _buildProfileInfoRows(),
          const SizedBox(height: 16),
          const Text(
            AppStrings.petBio,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            petProfile.bio,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Text(
          petProfile.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.verified,
          color: Colors.blue,
          size: 24,
        ),
      ],
    );
  }

  Widget _buildProfileInfoRows() {
    return Column(
      children: [
        ProfileInfoRowWidget(
          icon: Icons.pets,
          label: AppStrings.petBreed,
          value: petProfile.breed,
        ),
        ProfileInfoRowWidget(
          icon: Icons.location_on,
          label: AppStrings.petLocation,
          value: petProfile.location,
        ),
        ProfileInfoRowWidget(
          icon: Icons.info,
          label: AppStrings.petBio,
          value: petProfile.bio,
        ),
      ],
    );
  }
}

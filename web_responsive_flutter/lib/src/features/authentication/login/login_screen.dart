import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_fields/text/custom_text_field.dart';
import '../../../common_widgets/buttons/primary_button.dart';
import 'provider/login_screen_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(context, authProvider);
          } else {
            return _buildTabletWebLayout(context, height, width, authProvider);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AuthProvider authProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          const SizedBox(height: 20),
          _buildWelcomeText(),
          _buildForm(authProvider),
        ],
      ),
    );
  }

  Widget _buildTabletWebLayout(BuildContext context, double height, double width, AuthProvider authProvider) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.loginBackFullImg),
          fit: BoxFit.fill,
        ),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Row(
          children: [
            Expanded(
              child: Container(margin: EdgeInsets.symmetric(horizontal: width * 0.1)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 30),
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLogo(),
                            const SizedBox(height: 20),
                            _buildWelcomeText(),
                            _buildForm(authProvider),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(),
      child: SvgPicture.asset(
        AppImages.loginLogo,
        height: 42.93,
        width: 130.16,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome to the",
          style: TextStyle(
            color: Color(0xFF1B242C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Dashboard",
          style: TextStyle(
            color: Color(0xFF1B242C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(AuthProvider authProvider) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            "Username",
            style: TextStyle(color: Color(0xFF1B242C), fontSize: 14, fontWeight: FontWeight.w400),
          ),
          CustomTextField(
            controller: _usernameController,
            labelText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            textInputAction: TextInputAction.next, onSaved: (String? value) {  },
          ),
          const SizedBox(height: 16),
          const Text(
            "Password",
            style: TextStyle(color: Color(0xFF1B242C), fontSize: 14, fontWeight: FontWeight.w400),
          ),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            isPassword: true,
            isDarkThemed: false,
            passIconColor: Colors.grey, onSaved: (String? value) {  },
          ),
          const SizedBox(height: 20),
          _buildLoginButton(authProvider),
          const SizedBox(height: 20),
          _buildDividerWithText(),
          const SizedBox(height: 20),
          _buildGoogleLoginButton(authProvider),
        ],
      ),
    );
  }

  Widget _buildLoginButton(AuthProvider authProvider) {
    return PrimaryButton(
      backgroundColor: AppColors.btnRedColor,
      text: authProvider.loading ? 'Loading' : 'Login',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          authProvider.login(_usernameController.text.trim(), _passwordController.text.trim());
          GoRouter.of(context).go('/mainScreen');
        }
      },
    );
  }


  Widget _buildGoogleLoginButton(AuthProvider authProvider) {

    return PrimaryButton(
      imageIcon: SvgPicture.asset(AppImages.googleLogo, height: 24, width: 24),
      backgroundColor: AppColors.whiteColor,
      text: authProvider.loading ? 'Loading' : 'Sign in with Google',
      foregroundColor: Colors.black,
      borderColor: const Color(0xFF9EA8B3),
      onPressed: () {

      },
    );
  }

  Widget _buildDividerWithText() {
    return const Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.dividerColor, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0), // Add some space around the "Or"
          child: Text(
            "Or",
            style: TextStyle(color: AppColors.dividerColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.dividerColor, thickness: 1),
        ),
      ],
    );
  }

}

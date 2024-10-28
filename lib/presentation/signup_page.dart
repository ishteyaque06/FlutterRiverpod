import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtest/presentation/viewmodel/auth_view_model.dart';
import 'package:riverpodtest/widgets/auth_gradient_button.dart';
import 'package:riverpodtest/widgets/custom_field.dart';

//Converting it for Riverpod
class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Use Watch method to listen the state changes
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    //use re.listen if want to show error or navigate to other page if success
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(data: (data) {
        // Navigate on success
      }, error: (error, stacktrace) {
        //Show Error Message
      }, loading: () {
        //Not needed as we can not return widget
      });
    });
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SignUp',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    CustomField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    CustomField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscure: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthGradientButton(
                      title: 'SignUp',
                      onTap: () async {
                        //Use ref.read option to call function
                        await ref
                            .read(authViewModelProvider.notifier)
                            .loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

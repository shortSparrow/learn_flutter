import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/application/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/application/pages/advice/cubit/advice_cubit.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/custom_button.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/error_message.dart';
import 'package:provider/provider.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdviceCubit(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Advicer",
            style: themeData.textTheme.displayLarge,
          ),
          centerTitle: true,
          actions: [
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdviceCubit, AdviceCubitState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case AdviceInitial:
                          return Text(
                            "Your advice is waiting for you!",
                            style: themeData.textTheme.displayLarge,
                          );

                        case AdviceStateLoading:
                          return CircularProgressIndicator(
                            color: themeData.colorScheme.secondary,
                          );

                        case AdviceStateLoaded:
                          return AdviceField(
                            advice: (state as AdviceStateLoaded).advice,
                          );

                        case AdviceStateError:
                          return ErrorMessage(
                            message: (state as AdviceStateError).errorMessage,
                          );

                        default:
                          return const SizedBox();
                      }

                      // if (state is AdviceInitial) {
                      //   return Text(
                      //     "Your advice is waiting for you!",
                      //     style: themeData.textTheme.displayLarge,
                      //   );
                      // } else if (state is AdviceStateLoading) {
                      //   return CircularProgressIndicator(
                      //     color: themeData.colorScheme.secondary,
                      //   );
                      // } else if (state is AdviceStateLoaded) {
                      //   return AdviceField(
                      //     advice: state.advice,
                      //   );
                      // } else if (state is AdviceStateError) {
                      //   return ErrorMessage(
                      //     message: state.errorMessage,
                      //   );
                      // } else {
                      //   return const SizedBox();
                      // }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(),
                ),
              ),
            ],
          ),
        ));
  }
}

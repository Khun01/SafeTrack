import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_bloc.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_event.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_state.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/services/profile_services.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final UserInformationBloc userInformationBloc =
        UserInformationBloc(profileServices: ProfileServices(baseUrl: baseUrl))
          ..add(GetUserEvent());
    return BlocProvider(
      create: (context) => userInformationBloc,
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Row(
          children: [
            const Center(
              child: Icon(
                Icons.account_circle,
                color: LightColor.primaryColor,
                size: 50,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: LightColor.blackSecondaryTextColor,
                  ),
                ),
                BlocBuilder<UserInformationBloc, UserInformationState>(
                  builder: (context, state) {
                    if (state is UserInformationSuccessState) {
                      final user = state.user;
                      return Text(
                        user.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                      );
                    }else if(state is UserInformationLoadingState){
                      return const SizedBox(
                        height: 23,
                        width: 23,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      );
                    }else{
                      return Text(
                        '',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          color: LightColor.blackSecondaryTextColor,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.notifications,
                  size: 28, color: LightColor.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

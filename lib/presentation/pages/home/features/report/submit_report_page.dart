// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_event.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_state.dart';
import 'package:safetrack/presentation/pages/home/features/report/confirmation_report_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/services/feature_services.dart';
import 'package:safetrack/services/global.dart';

class SubmitReportPage extends StatefulWidget {
  final String photo;
  const SubmitReportPage({
    super.key,
    required this.photo,
  });

  @override
  State<SubmitReportPage> createState() => _SubmitReportPageState();
}

class _SubmitReportPageState extends State<SubmitReportPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController description = TextEditingController();
  final TextEditingController location = TextEditingController();
  late final AnimationController controller;

  final List<String> dropdownOptions = ['High', 'Medium', 'Low'];
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyReportBloc myReportBloc =
        MyReportBloc(featureServices: FeatureServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => myReportBloc,
      child: BlocConsumer<MyReportBloc, MyReportState>(
        listener: (context, state) {
          if (state is SubmitReportSuccessState) {
            navigationAnimation(
              context,
              const ConfirmationReportPage(),
              SharedAxisTransitionType.horizontal,
            );
          } else if (state is SubmitReportErrorState) {
            toast(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: LightColor.backgroundColor,
            body: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: state is SubmitReportLoadingState
                    ? Center(
                        child: Lottie.asset(
                          'assets/lottie/register_loading.json',
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 24,
                          right: 16,
                          bottom: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: LightColor.blackPrimaryTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      'Submit Report',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackPrimaryTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 210,
                                  width: 210,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(widget.photo),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    hint: Text(
                                      'Priority type',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackAccentColor,
                                      ),
                                    ),
                                    iconDisabledColor: LightColor.primaryColor,
                                    iconEnabledColor: LightColor.primaryColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        top: 0,
                                        bottom: 0,
                                        right: 12,
                                      ),
                                      hintStyle: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackAccentColor,
                                      ),
                                      fillColor: LightColor.inputField,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    items: dropdownOptions
                                        .map((option) =>
                                            DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(
                                                option,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: LightColor
                                                      .blackPrimaryTextColor,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: TextFormField(
                                controller: description,
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: null,
                                expands: true,
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.blackPrimaryTextColor,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                    left: 12,
                                    top: 12,
                                    bottom: 12,
                                    right: 12,
                                  ),
                                  hintText: 'Message',
                                  hintStyle: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: LightColor.blackAccentColor,
                                  ),
                                  fillColor: LightColor.inputField,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 2,
                              color: LightColor.dividerColor,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.add_location_alt_rounded,
                                  color: LightColor.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Location',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              LightColor.blackPrimaryTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        height: 20,
                                        child: TextFormField(
                                          controller: location,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 14,
                                            color: LightColor
                                                .blackPrimaryTextColor,
                                          ),
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (location.text.isNotEmpty &&
                                      description.text.isNotEmpty) {
                                    context
                                        .read<MyReportBloc>()
                                        .add(SubmitButtonEvent(
                                          reportImage: widget.photo,
                                          priority: selectedOption ?? 'Low',
                                          description: description.text,
                                          location: location.text,
                                        ));
                                  } else {
                                    snackBar(
                                      context,
                                      'PLease fill in the form first',
                                      LightColor.blackPrimaryTextColor,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: LightColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: LightColor.whitePrimaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

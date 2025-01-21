import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:safetrack/presentation/widgets/my_verification_form.dart';

class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({super.key});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final List<TextEditingController> controllers = List.generate(
    9,
    (index) => TextEditingController(),
  );
  double progress = 0.0;
  String? selectedOption;
  final List<String> dropdownOptions = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0, end: 0).animate(controller)
      ..addListener(() {
        setState(() {
          progress = animation.value;
        });
      });
    controller.reset();
  }

  void updateProgress() {
    int completedFields =
        controllers.where((controller) => controller.text.isNotEmpty).length;
    if (selectedOption != null) {
      completedFields++;
    }
    double newProgress = completedFields / controllers.length;
    animation = Tween<double>(begin: progress, end: newProgress)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Verification',
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Basic Information',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Full name',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                MyVerificationForm(
                                  hintText: 'ex. John Brandon B. Lambino',
                                  controller: controllers[0],
                                  onChanged: () {
                                    updateProgress();
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                DropdownButtonFormField(
                                  hint: Text(
                                    'Gender',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0x333B3B3B),
                                    ),
                                  ),
                                  iconDisabledColor: const Color(0xFF023E8A),
                                  iconEnabledColor: const Color(0xFF023E8A),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                    updateProgress();
                                  },
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
                                      color: const Color(0x333B3B3B),
                                    ),
                                    fillColor: const Color(0x1A023E8A),
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
                                  items: dropdownOptions
                                      .map((option) => DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(
                                              option,
                                              style: GoogleFonts.quicksand(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF3B3B3B),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Address',
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(House No.)',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: MyVerificationForm(
                              hintText: 'ex. 100',
                              controller: controllers[2],
                              keyboardType: TextInputType.number,
                              onChanged: () {
                                updateProgress();
                              },
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            flex: 4,
                            child: MyVerificationForm(
                              hintText:
                                  'ex. San Vicente, San Jacinto, Pangasinan',
                              controller: controllers[3],
                              onChanged: () {
                                updateProgress();
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact number',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0x1A023E8A),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+63',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF3B3B3B),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      flex: 3,
                                      child: MyVerificationForm(
                                        hintText: 'ex. 9** *** ****',
                                        controller: controllers[4],
                                        keyboardType: TextInputType.number,
                                        onChanged: () {
                                          updateProgress();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date of Birth',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                MyVerificationForm(
                                  hintText: '09/09/1998',
                                  controller: controllers[5],
                                  onChanged: () {
                                    updateProgress();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Emergency Contact',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Full name',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      MyVerificationForm(
                        hintText: 'ex. John Brandon B. Lambino',
                        controller: controllers[6],
                        onChanged: () {
                          updateProgress();
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Emergency Contact number',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0x1A023E8A),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+63',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF3B3B3B),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      flex: 3,
                                      child: MyVerificationForm(
                                        hintText: '9** *** ****',
                                        controller: controllers[7],
                                        keyboardType: TextInputType.number,
                                        onChanged: () {
                                          updateProgress();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Relationship',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                MyVerificationForm(
                                  hintText: 'ex. Girlfriend',
                                  controller: controllers[8],
                                  onChanged: () {
                                    updateProgress();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Identity Verification',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Barangay ID or Government ID',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 150,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: const DashedBorder.fromBorderSide(
                            side: BorderSide(
                              color: Color(0xFFE5E9F4),
                              width: 2,
                            ),
                            dashLength: 10,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Expanded(
                              child: Icon(
                                Icons.cloud_download,
                                color: Color(0x33023E8A),
                                size: 90,
                              ),
                            ),
                            Text(
                              'Please upload a clear photo of your Barangay ID or any valid government-issued ID.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF023E8A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCFCFC),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 66)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFCFC),
                  border: Border.all(color: const Color(0x333B3B3B)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A023E8A),
                      offset: Offset(0.0, -6.0),
                      blurRadius: 4.0,
                      spreadRadius: -4.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearPercentIndicator(
                      lineHeight: 8,
                      padding: EdgeInsets.zero,
                      percent: progress.clamp(0.0, 1.0),
                      progressColor: const Color(0xFF023E8A),
                      backgroundColor: const Color(0x1A023E8A),
                      barRadius: const Radius.circular(500),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

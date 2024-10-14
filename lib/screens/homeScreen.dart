import 'package:bmi_calculator/methods/getCaption.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants/appConstants.dart';
import 'package:bmi_calculator/widgets/leftBar.dart';
import 'package:bmi_calculator/widgets/rightBar.dart';
import 'package:bmi_calculator/methods/getBmiColor.dart';
import 'package:google_fonts/google_fonts.dart';
import "dart:math";

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;
  String _textResult = "";
  bool _showText = false;

  late AnimationController _controller;
  late Animation<double> _bmiAnimation; // counting effect

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _bmiAnimation = Tween<double>(begin: 0, end: _bmiResult).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showText = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: TextStyle(
              color: accentHexColor,
              fontSize: 25.0, // Reduced font size for title
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 3,
        centerTitle: true,
      ),
      backgroundColor: mainHexColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  height: 60,
                  child: TextField(
                    controller: _heightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Height",
                      labelStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentHexColor)),
                    ),
                    cursorColor: accentHexColor,
                  ),
                ),
                Container(
                  width: 150,
                  height: 60,
                  child: TextField(
                    controller: _weightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Weight",
                      labelStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: accentHexColor)),
                    ),
                    cursorColor: accentHexColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                if (_heightController.text.isEmpty ||
                    _weightController.text.isEmpty) {
                  // Show a SnackBar if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter both height and weight'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  double _h = double.parse(_heightController.text);
                  double _w = double.parse(_weightController.text);
                  setState(() {
                    _bmiResult = _w / pow(_h / 100, 2);
                    _showText = false;

                    _textResult = getCaption(_bmiResult);

                    _controller.forward(from: 0.0); // start counting

                    _bmiAnimation = Tween<double>(begin: 0, end: _bmiResult)
                        .animate(CurvedAnimation(
                            parent: _controller, curve: Curves.easeOut));
                  });
                }
              },
              child: Text("Calculate",
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: mainHexColor,
                      fontSize: 20.0, // Reduced font size for title
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentHexColor,
                foregroundColor: mainHexColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            AnimatedBuilder(
              animation: _bmiAnimation,
              builder: (context, child) {
                Color currentColor = getBmiColor(_bmiAnimation.value);
                return Text(
                  _bmiAnimation.value.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.w500,
                      color: currentColor),
                );
              },
            ),
            // Container(
            //   child: Text(
            //     _bmiResult.toStringAsFixed(2),
            //     style: TextStyle(
            //         fontSize: 90,
            //         fontWeight: FontWeight.w500,
            //         color: accentHexColor),
            //   ),
            // ),
            SizedBox(
              height: 50,
            ),
            AnimatedOpacity(
              opacity: _showText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Container(
                child: Text(_textResult,
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(fontSize: 30, color: accentHexColor),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Rightbar(barWidth: 40),
            SizedBox(
              height: 20,
            ),
            Rightbar(barWidth: 70),
            SizedBox(
              height: 20,
            ),
            Rightbar(barWidth: 40),
            SizedBox(
              height: 20,
            ),
            Leftbar(barWidth: 70),
            SizedBox(
              height: 50,
            ),
            Leftbar(barWidth: 70),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

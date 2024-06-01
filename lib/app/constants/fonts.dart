import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

mixin CustomFontStyle {
  static TextStyle heading = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      letterSpacing: 1,
    ),
  );

  static TextStyle normal = GoogleFonts.roboto(
      textStyle: TextStyle(
          color: Colors.black87,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal));

  static TextStyle medium = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: Colors.black87));
}
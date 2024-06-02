import 'dart:io'; // Add this import for File
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/fonts.dart';
import '../../../constants/spaces.dart';
import '../../home/home_model/home_model.dart';
import '../controllers/view_user_data_controller.dart';

class ViewUserDataView extends GetView<ViewUserDataController> {
  const ViewUserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Total number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('View User Data', style: CustomFontStyle.heading),
          centerTitle: true,
          bottom: TabBar(
            labelStyle: CustomFontStyle.normal,
            tabs: const [
              Tab(text: 'Text Only'),
              Tab(text: 'Image Only'),
              Tab(text: 'PDF Only'),
              Tab(text: 'Text & Image'),
              Tab(text: 'Text & PDF'),
              Tab(text: 'Text, Image & PDF'),
            ],
          ),
        ),
        body: Obx(() {
          return TabBarView(
            children: [
              buildTabContent(controller.textOnlyActivities),
              buildTabContent(controller.imageOnlyActivities),
              buildTabContent(controller.pdfOnlyActivities),
              buildTabContent(controller.textAndImageActivities),
              buildTabContent(controller.textAndPdfActivities),
              buildTabContent(controller.textImageAndPdfActivities),
            ],
          );
        }),
      ),
    );
  }

  Widget buildTabContent(List<HomeModel> activities) {
    if (activities.isEmpty) {
      return const Center(child: Text('No activities found'));
    }

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: ListTile(
            tileColor: Colors.grey[200],
            title: Text('Activity by User: ${activity.userId}',
                style: CustomFontStyle.normal),
            subtitle: getActivityContent(activity),
          ),
        );
      },
    );
  }

  Widget getActivityContent(HomeModel activity) {
    final String imageUrl = activity.imageUrl ?? '';
    final String pdfUrl = activity.pdfUrl ?? '';
    final String text = activity.text ?? '';

    if (imageUrl.isNotEmpty && pdfUrl.isEmpty && text.isEmpty) {
      // Only image
      if (Uri.parse(imageUrl).scheme.contains('http')) {
        // Network image
        return Image.network(imageUrl,
            height: 100, width: 100, fit: BoxFit.cover);
      } else {
        // Local file image
        return Image.file(File(imageUrl),
            height: 100, width: 100, fit: BoxFit.cover);
      }
    } else if (pdfUrl.isNotEmpty && imageUrl.isEmpty && text.isEmpty) {
      // Only PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.picture_as_pdf, size: 10 * 3.sp),
          const Text('PDF available'),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: const Text('Open PDF'),
          ),
        ],
      );
    } else if (text.isNotEmpty && imageUrl.isEmpty && pdfUrl.isEmpty) {
      // Only text
      return Text(text, style: CustomFontStyle.normal);
    } else if (imageUrl.isNotEmpty && text.isNotEmpty && pdfUrl.isEmpty) {
      // Text with image
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: CustomFontStyle.normal),
          Spaces.y2,
          if (Uri.parse(imageUrl).scheme.contains('http'))
            Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover)
          else
            Image.file(File(imageUrl),
                height: 100, width: 100, fit: BoxFit.cover),
        ],
      );
    } else if (pdfUrl.isNotEmpty && text.isNotEmpty && imageUrl.isEmpty) {
      // Text with PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: CustomFontStyle.normal),
          Spaces.y1,
          Icon(Icons.picture_as_pdf, size: 30.sp),
          Text('PDF available', style: CustomFontStyle.normal),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: const Text('Open PDF'),
          ),
        ],
      );
    } else if (pdfUrl.isNotEmpty && imageUrl.isNotEmpty && text.isEmpty) {
      // Image with PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Uri.parse(imageUrl).scheme.contains('http'))
            Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover)
          else
            Image.file(File(imageUrl),
                height: 100, width: 100, fit: BoxFit.cover),
          Spaces.y1,
          const Icon(Icons.picture_as_pdf, size: 50),
          Text('PDF available', style: CustomFontStyle.normal),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: const Text('Open PDF'),
          ),
        ],
      );
    } else if (pdfUrl.isNotEmpty && imageUrl.isNotEmpty && text.isNotEmpty) {
      // Text with image and PDF
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: CustomFontStyle.normal),
            Spaces.y1,
            if (Uri.parse(imageUrl).scheme.contains('http'))
              Image.network(imageUrl,
                  height: 100, width: 100, fit: BoxFit.cover)
            else
              Image.file(File(imageUrl),
                  height: 100, width: 100, fit: BoxFit.cover),
            Spaces.y1,
            const Icon(Icons.picture_as_pdf, size: 50),
            Text('PDF available', style: CustomFontStyle.normal),
            TextButton(
              onPressed: () {
                _openPdf(pdfUrl);
              },
              child: const Text('Open PDF'),
            ),
          ],
        ),
      );
    } else {
      return const Text('No content available');
    }
  }

  void _openPdf(String pdfUrl) async {
    final Uri uri = Uri.parse(pdfUrl);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      Get.snackbar('Error', 'Could not open PDF');
    }
  }
}
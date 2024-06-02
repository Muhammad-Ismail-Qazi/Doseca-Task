import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/fonts.dart';
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
          bottom: const TabBar(
            tabs: [
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
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text('Activity by User: ${activity.userId}'),
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
      return Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover);
    } else if (pdfUrl.isNotEmpty && imageUrl.isEmpty && text.isEmpty) {
      // Only PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.picture_as_pdf, size: 50),
          Text('PDF available'),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: Text('Open PDF'),
          ),
        ],
      );
    } else if (text.isNotEmpty && imageUrl.isEmpty && pdfUrl.isEmpty) {
      // Only text
      return Text(text);
    } else if (imageUrl.isNotEmpty && text.isNotEmpty && pdfUrl.isEmpty) {
      // Text with image
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          SizedBox(height: 8),
          Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover),
        ],
      );
    } else if (pdfUrl.isNotEmpty && text.isNotEmpty && imageUrl.isEmpty) {
      // Text with PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          SizedBox(height: 8),
          Icon(Icons.picture_as_pdf, size: 50),
          Text('PDF available'),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: Text('Open PDF'),
          ),
        ],
      );
    } else if (pdfUrl.isNotEmpty && imageUrl.isNotEmpty && text.isEmpty) {
      // Image with PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover),
          SizedBox(height: 8),
          Icon(Icons.picture_as_pdf, size: 50),
          Text('PDF available'),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: Text('Open PDF'),
          ),
        ],
      );
    } else if (pdfUrl.isNotEmpty && imageUrl.isNotEmpty && text.isNotEmpty) {
      // Text with image and PDF
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          SizedBox(height: 8),
          Image.network(imageUrl, height: 100, width: 100, fit: BoxFit.cover),
          SizedBox(height: 8),
          Icon(Icons.picture_as_pdf, size: 50),
          Text('PDF available'),
          TextButton(
            onPressed: () {
              _openPdf(pdfUrl);
            },
            child: Text('Open PDF'),
          ),
        ],
      );
    } else {
      return Text('No content available');
    }
  }

  void _openPdf(String pdfUrl) {
    // Implement PDF opening logic
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../constants/firebase.dart';
import '../../home/home_model/home_model.dart';

class ViewUserDataController extends GetxController {
  var activities = <HomeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    try {
      final user = firebaseAuthInstance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await userDataCollection
            .where('userId', isEqualTo: user.uid)
            .get();
        activities.assignAll(querySnapshot.docs
            .map((doc) => HomeModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());

        // Print detailed information about the fetched data
        for (var activity in activities) {
          print('User ID: ${activity.userId}, Text: ${activity.text}, Image URL: ${activity.imageUrl}, PDF URL: ${activity.pdfUrl}');
        }

      }
      print("Data are here");
      print(activities.value);
    } catch (exception) {
      Get.snackbar('Failed to fetch data', exception.toString());
      print(exception);
    }
  }

  List<HomeModel> get textOnlyActivities {
    var list = activities.where((activity) =>
    activity.text?.isNotEmpty == true &&
        activity.imageUrl?.isEmpty == true &&
        activity.pdfUrl?.isEmpty == true).toList();
    print('Text Only Activities: $list');
    return list;
  }

  List<HomeModel> get imageOnlyActivities {
    var list = activities.where((activity) =>
    activity.imageUrl?.isNotEmpty == true &&
        activity.text?.isEmpty == true &&
        activity.pdfUrl?.isEmpty == true).toList();
    print('Image Only Activities: $list');
    return list;
  }

  List<HomeModel> get pdfOnlyActivities {
    var list = activities.where((activity) =>
    activity.pdfUrl?.isNotEmpty == true &&
        activity.text?.isEmpty == true &&
        activity.imageUrl?.isEmpty == true).toList();
    print('PDF Only Activities: $list');
    return list;
  }

  List<HomeModel> get textAndImageActivities {
    var list = activities.where((activity) =>
    activity.text?.isNotEmpty == true &&
        activity.imageUrl?.isNotEmpty == true &&
        activity.pdfUrl?.isEmpty == true).toList();
    print('Text and Image Activities: $list');
    return list;
  }

  List<HomeModel> get textAndPdfActivities {
    var list = activities.where((activity) =>
    activity.text?.isNotEmpty == true &&
        activity.pdfUrl?.isNotEmpty == true &&
        activity.imageUrl?.isEmpty == true).toList();
    print('Text and PDF Activities: $list');
    return list;
  }

  List<HomeModel> get textImageAndPdfActivities {
    var list = activities.where((activity) =>
    activity.text?.isNotEmpty == true &&
        activity.imageUrl?.isNotEmpty == true &&
        activity.pdfUrl?.isNotEmpty == true).toList();
    print('Text, Image and PDF Activities: $list');
    return list;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
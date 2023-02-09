import 'package:get/get.dart';
import 'package:school_guide/controllers/agent_controller.dart';
import 'package:school_guide/controllers/banner_controller.dart';
import 'package:school_guide/controllers/curriculum_controller.dart';
import 'package:school_guide/controllers/edu_blog_controller.dart'; 
import 'package:school_guide/controllers/scholarship_controller.dart';
import 'package:school_guide/controllers/school_views_controller.dart';
import 'package:school_guide/controllers/school_controller.dart';
import 'package:school_guide/controllers/tutor_controller.dart';
import 'package:school_guide/controllers/video_controller.dart';
import 'package:school_guide/controllers/views_controller.dart';
import 'package:school_guide/services/cloud_messaging_service.dart';

class Controller {
  static initializeControllers() {
    Get.put(BannerController());
    Get.put(SchoolsController());
    Get.put(EduBlogController());
    Get.put(VideoController());
    Get.put(ScholarshipController());
    Get.put(AgentController()); 
    Get.put(CurriculumController());
    Get.put(TutorController());
    Get.put(ViewsController());
    Get.put(CloudMessaging());
    Get.put(SchoolViewsController());
  }
}

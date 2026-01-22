import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:resume_maker/Widget/logger.dart';

import '../Services/create_pdf.dart';
import '../Utility/app_color.dart';
import '../Utility/utils.dart';

class CreateResumeController extends GetxController {
  final mobileFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final pincodeFormKey = GlobalKey<FormState>();

  //Personal Data Controller
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final userDesignationController = TextEditingController().obs;
  final mobileController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final pincodeController = TextEditingController().obs;

  final continueCount = 0.obs;
  final proficiencyCount = 0.obs;
  final langProCount = 0.obs;
  final isFinalSubmit = false.obs;

  //Summary var
  final summaryController = TextEditingController().obs;

  //Skill var
  final skillController = TextEditingController().obs;
  final toolController = TextEditingController().obs;
  final otherSkillsController = TextEditingController().obs;

  //Langauge
  final languageController = TextEditingController().obs;

  //Social Site
  final socialTextController = TextEditingController().obs;

  //Job Details Data
  final jobTitleController = TextEditingController().obs;
  final employerController = TextEditingController().obs;
  final employerCityController = TextEditingController().obs;
  final countryController = TextEditingController().obs;
  final detailsController = TextEditingController().obs;
  final fromDate = Rx<DateTime?>(null);
  final toDate = Rx<DateTime?>(null);

  //Education Details Data
  final degreeController = TextEditingController().obs;
  final univercityController = TextEditingController().obs;
  final placeController = TextEditingController().obs;
  final startDate = Rx<DateTime?>(null);
  final endDate = Rx<DateTime?>(null);

  //Project Details
  final projectNameController = TextEditingController().obs;
  final durationController = TextEditingController().obs;
  final environmentController = TextEditingController().obs;
  final overviewController = TextEditingController().obs;
  final fetureController = TextEditingController().obs;
  final rulesController = TextEditingController().obs;

  // List
  final skillsList = skillListData.obs;
  final jobList = jobListData.obs;
  final educationList = educationListData.obs;
  final languageList = langListData.obs;
  final socialDataList = socialListData.obs;
  final projectList = priojectListData.obs;

  final isLoading = false.obs;

  //Color Selection ON Review
  final selectedColor = AppColors.blue.obs;

  final isRedClick = false.obs;
  final isPinkClick = false.obs;
  final isPurpleClick = false.obs;
  final isYellowClick = false.obs;
  final isGreenClick = false.obs;
  final isGreyClick = false.obs;
  final isBlueClick = false.obs;
  final isOrangeClick = false.obs;

  //selected Template
  final selectedTempIndex = Rxn<int>();

  @override
  void dispose() {
    //First Page Controller
    firstNameController.value.clear();
    lastNameController.value.clear();
    addressController.value.clear();
    userDesignationController.value.clear();
    mobileController.value.clear();
    emailController.value.clear();
    pincodeController.value.clear();

    //Summay Controller
    summaryController.value.clear();
    toolController.value.clear();
    otherSkillsController.value.clear();

    //langauge
    languageController.value.clear();

    //social Controller
    socialTextController.value.clear();

    // Job Controller
    jobTitleController.value.clear();
    employerController.value.clear();
    employerCityController.value.clear();
    countryController.value.clear();
    detailsController.value.clear();

    // Education Controller
    degreeController.value.clear();
    univercityController.value.clear();
    placeController.value.clear();

    //project Controller
    projectNameController.value.clear();
    durationController.value.clear();
    environmentController.value.clear();
    overviewController.value.clear();
    fetureController.value.clear();
    rulesController.value.clear();
    super.dispose();
  }

  // Click On Continue
  void clickOnContinue(int flag) {
    final selectedIndex = selectedTempIndex.value;

    Logger.logData("Selected Index : $selectedIndex && Count :$continueCount");

    if (selectedIndex == null) {
      initialContinueClick(flag);
    } else {
      firstContinueClick(flag);
    }
  }

  //Click ON Back
  void clickOnBack() {
    if (continueCount > 0) {
      continueCount.value--;
    }
  }

  //Skill Proficiency
  void addProficiency(int index) {
    proficiencyCount.value = index;
  }

  //Skill Proficiency
  void addLangProficiency(int index) {
    langProCount.value = index;
  }

  //Add Skill List Data
  void clickOnSkillAdd() {
    if (skillController.value.text.isEmpty) {
      commonDialog("Please Enter Skill");
      return;
    }

    if (selectedTempIndex.value == 2 && toolController.value.text.isEmpty) {
      commonDialog("Please Add Using tools");
      return;
    }

    if (selectedTempIndex.value == 2 &&
        otherSkillsController.value.text.isEmpty) {
      commonDialog("Please Add Other technology");
      return;
    }

    skillsList.clear();

    final param = {
      "skill": skillController.value.text.trim(),
      "proficiency": proficiencyCount.value,
      "tools": toolController.value.text.trim(),
      "other_skills": otherSkillsController.value.text.trim(),
    };
    skillsList.add(param);

    skillController.value.clear();
    toolController.value.clear();
    otherSkillsController.value.clear();
    proficiencyCount.value = 0;
  }

  //Add Langauge List Data
  void clickOnLangAdd() {
    if (languageController.value.text.isEmpty) {
      commonDialog("Please Enter valid Data");
      return;
    }

    languageList.clear();

    final param = {
      "lang": languageController.value.text,
      "proficiency": langProCount.value,
    };
    languageList.add(param);

    languageController.value.clear();
    langProCount.value = 0;
  }

  bool forInitialCount() {
    if (firstNameController.value.text.isEmpty) {
      commonDialog("Please enter first Name.");
      return false;
    }

    if (lastNameController.value.text.isEmpty) {
      commonDialog("Please enter Last Name.");
      return false;
    }

    if (addressController.value.text.isEmpty) {
      commonDialog("Please enter Address.");
      return false;
    }

    if (pincodeController.value.text.isEmpty) {
      commonDialog("Please enter Pincode.");
      return false;
    }

    if (mobileController.value.text.isEmpty) {
      commonDialog("Please enter Mobile Number");
      return false;
    }

    if (emailController.value.text.isEmpty) {
      commonDialog("Please enter Email ID");
      return false;
    }

    if (pincodeController.value.text.length != 6) {
      commonDialog("Please enter valid Pin Code");
      return false;
    }

    if (mobileController.value.text.length != 10) {
      commonDialog("Please enter valid mobile Number");
      return false;
    }

    final firstItem = mobileController.value.text.trim().substring(0, 1);

    if (firstItem != "9" && firstItem != "8" && firstItem != "7") {
      commonDialog("Please enter valid mobile Number");
      return false;
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!emailRegex.hasMatch(emailController.value.text.trim())) {
      commonDialog("Please enter valid email Id");
      return false;
    }

    return true;
  }

  bool forSummaryCount() {
    if (summaryController.value.text.isEmpty) {
      commonDialog("Please enter Summary");
      return false;
    }
    return true;
  }

  bool forSkillCount() {
    if (skillsList.isEmpty) {
      commonDialog("Please enter at least one Skill");
      return false;
    }
    return true;
  }

  bool forProjectCount() {
    if (projectList.isEmpty) {
      commonDialog("Please enter at least one Project");
      return false;
    }
    return true;
  }

  bool forJobCount() {
    if (jobList.isEmpty) {
      commonDialog("Please enter Experience");
      return false;
    }

    return true;
  }

  bool forEducationCount() {
    if (educationList.isEmpty) {
      commonDialog("Please enter Eduction");
      return false;
    }

    return true;
  }

  bool forLangCount() {
    if (languageList.isEmpty) {
      commonDialog("Please enter at least one known Language");
      return false;
    }
    return true;
  }

  bool forSocialCount() {
    if (socialDataList.isEmpty) {
      commonDialog("Please enter at least one Social Side");
      return false;
    }
    return true;
  }

  //from Date
  void fromDateCalender(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1991),
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate != null) {
      fromDate.value = pickedDate;
    }
  }

  //TO Date
  void toDateCalender(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1991),
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate != null) {
      toDate.value = pickedDate;
    }
  }

  //Add Experience List Data
  void clickOnJobAdd() {
    if (jobTitleController.value.text.isEmpty) {
      commonDialog("Please Enter job title");
      return;
    }

    if (employerController.value.text.isEmpty) {
      commonDialog("Please Enter employer Name");
      return;
    }

    if (employerCityController.value.text.isEmpty) {
      commonDialog("Please Enter job location");
      return;
    }

    if (fromDate.value == null) {
      commonDialog("Please Enter job starting Date");
      return;
    }

    if (toDate.value == null) {
      commonDialog("Please Enter job ending Date");
      return;
    }

    jobList.clear();

    final param = {
      "jobtitle": jobTitleController.value.text.trim(),
      "employerName": employerController.value.text.trim(),
      "city": employerCityController.value.text.trim(),
      "details": detailsController.value.text.trim(),
      "fromDate": fromDate.value,
      "toDate": toDate.value,
    };

    jobList.add(param);

    jobTitleController.value.clear();
    employerController.value.clear();
    employerCityController.value.clear();
    detailsController.value.clear();
    fromDate.value = null;
    toDate.value = null;
  }

  //Add Experience List Data
  void clickOnEducationAdd() {
    if (degreeController.value.text.isEmpty) {
      commonDialog("Please Enter Degree");
      return;
    }

    if (univercityController.value.text.isEmpty) {
      commonDialog("Please Enter university or school name");
      return;
    }

    if (placeController.value.text.isEmpty) {
      commonDialog("Please Enter location");
      return;
    }

    if (startDate.value == null) {
      commonDialog("Please Enter job starting Date");
      return;
    }

    if (endDate.value == null) {
      commonDialog("Please Enter job ending Date");
      return;
    }

    educationList.clear();

    final param = {
      "degree": degreeController.value.text.trim(),
      "university": univercityController.value.text.trim(),
      "city": placeController.value.text.trim(),
      "startDate": startDate.value,
      "endDate": endDate.value,
    };

    educationList.add(param);

    degreeController.value.clear();
    univercityController.value.clear();
    placeController.value.clear();
    startDate.value = null;
    endDate.value = null;
  }

  //Add Social Media List Data
  void clickOnSocialMediaAdd() {
    if (socialTextController.value.text.isEmpty) {
      commonDialog("Please Enter valid Data");
      return;
    }

    socialDataList.clear();

    socialDataList.add(socialTextController.value.text.trim());

    socialTextController.value.clear();
  }

  //Start Date
  void startDateCalender(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1991),
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate != null) {
      startDate.value = pickedDate;
    }
  }

  //End Date
  void endDateCalender(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1991),
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate != null) {
      endDate.value = pickedDate;
    }
  }

  //Add Project List Data
  void clickOnProjectAdd() {
    if (projectNameController.value.text.isEmpty) {
      commonDialog("Please Enter Project Name");
      return;
    }

    if (selectedTempIndex.value != 2 && durationController.value.text.isEmpty) {
      commonDialog("Please Enter duration of Project");
      return;
    }

    if (selectedTempIndex.value != 2 &&
        environmentController.value.text.isEmpty) {
      commonDialog("Please Enter Used Technology");
      return;
    }

    if (selectedTempIndex.value != 2 && overviewController.value.text.isEmpty) {
      commonDialog("Please Enter at least one overview.");
      return;
    }

    if (selectedTempIndex.value != 2 && fetureController.value.text.isEmpty) {
      commonDialog("Please Enter at least one feature");
      return;
    }

    if (rulesController.value.text.isEmpty) {
      commonDialog("Please Enter at least one Responsibility");
      return;
    }

    projectList.clear();

    final param = {
      "projectName": projectNameController.value.text.trim(),
      "duration": durationController.value.text.trim(),
      "technology": environmentController.value.text.trim(),
      "overview": overviewController.value.text.trim(),
      "feature": fetureController.value.text.trim(),
      "rules": rulesController.value.text.trim(),
    };

    projectList.add(param);

    projectNameController.value.clear();
    durationController.value.clear();
    environmentController.value.clear();
    overviewController.value.clear();
    fetureController.value.clear();
    rulesController.value.clear();
  }

  void createPdf(int flag) async {
    try {
      isLoading.value = true;

      final pdfBytes = await createBiodataPdf(this, flag);

      if (kIsWeb) {
        // WEB: Direct download
        await FilePicker.platform.saveFile(
          dialogTitle: 'Save Resume',
          fileName: 'Resume.pdf',
          bytes: pdfBytes,
        );
      } else {
        // MOBILE: Use temp directory
        final tempDir = await path.getTemporaryDirectory();
        final file = File("${tempDir.path}/resume.pdf");
        await file.writeAsBytes(pdfBytes);

        await FilePicker.platform.saveFile(
          dialogTitle: 'Save Resume',
          fileName: 'Resume.pdf',
          bytes: await file.readAsBytes(),
        );

        await file.delete();
      }
    } catch (e) {
      Logger.logData("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //Selection of Red
  void selectionOfRed() {
    isRedClick.value = true;
    selectedColor.value = AppColors.red;
    //Remaining
    isPinkClick.value = false;
    isPurpleClick.value = false;
    isYellowClick.value = false;
    isGreenClick.value = false;
    isGreyClick.value = false;
    isBlueClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of Pink
  void selectionOfPink() {
    isPinkClick.value = true;
    selectedColor.value = AppColors.pink;
    //Remaining
    isRedClick.value = false;
    isPurpleClick.value = false;
    isYellowClick.value = false;
    isGreenClick.value = false;
    isGreyClick.value = false;
    isBlueClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of purple
  void selectionOfPurple() {
    isPurpleClick.value = true;
    selectedColor.value = AppColors.purple;
    //Remaining
    isRedClick.value = false;
    isPinkClick.value = false;
    isYellowClick.value = false;
    isGreenClick.value = false;
    isGreyClick.value = false;
    isBlueClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of Yellow
  void selectionOfYellow() {
    isYellowClick.value = true;
    selectedColor.value = AppColors.yellow;
    //Remaining
    isRedClick.value = false;
    isPinkClick.value = false;
    isPurpleClick.value = false;
    isGreenClick.value = false;
    isGreyClick.value = false;
    isBlueClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of Green
  void selectionOfGreen() {
    isGreenClick.value = true;
    selectedColor.value = AppColors.green;
    //Remaining
    isRedClick.value = false;
    isPinkClick.value = false;
    isPurpleClick.value = false;
    isYellowClick.value = false;
    isGreyClick.value = false;
    isBlueClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of Grey
  void selectionOfGrey() {
    isGreyClick.value = true;
    selectedColor.value = AppColors.blueGrey;
    //Remaining
    isRedClick.value = false;
    isPinkClick.value = false;
    isPurpleClick.value = false;
    isYellowClick.value = false;
    isGreenClick.value = false;
    isBlueClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of Grey
  void selectionOfBlue() {
    isBlueClick.value = true;
    selectedColor.value = AppColors.selectBlue;
    //Remaining
    isRedClick.value = false;
    isPinkClick.value = false;
    isPurpleClick.value = false;
    isYellowClick.value = false;
    isGreenClick.value = false;
    isGreyClick.value = false;
    isOrangeClick.value = false;
  }

  //Selection of Grey
  void selectionOfOrange() {
    isOrangeClick.value = true;
    selectedColor.value = AppColors.orange;
    //Remaining
    isRedClick.value = false;
    isPinkClick.value = false;
    isPurpleClick.value = false;
    isYellowClick.value = false;
    isGreenClick.value = false;
    isGreyClick.value = false;
    isBlueClick.value = false;
  }

  //Common Continue for Initial
  void initialContinueClick(int flag) {
    if (flag == 0) {
      if (continueCount.value == 0) {
        if (!forInitialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 1) {
        if (!forSummaryCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 2) {
        if (!forJobCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 3) {
        if (!forEducationCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 4) {
        if (!forProjectCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 5) {
        if (!forSkillCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 6) {
        if (!forLangCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 7) {
        if (!forSocialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value > 7) {
        isFinalSubmit.value = true;
      }
    } else {
      if (continueCount.value == 0) {
        if (!forInitialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 1) {
        if (!forSummaryCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 2) {
        if (!forEducationCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 3) {
        if (!forSkillCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 4) {
        if (!forLangCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 5) {
        if (!forSocialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value > 5) {
        isFinalSubmit.value = true;
      }
    }
  }

  //Common Continue For First Template
  void firstContinueClick(int flag) {
    if (flag == 0) {
      if (continueCount.value == 0) {
        if (!forInitialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 1) {
        if (!forSummaryCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 2) {
        if (!forSkillCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 3) {
        if (!forJobCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 4) {
        if (!forEducationCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 5) {
        if (!forProjectCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 6) {
        if (!forLangCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 7) {
        if (!forSocialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value > 7) {
        isFinalSubmit.value = true;
      }
    } else {
      if (continueCount.value == 0) {
        if (!forInitialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 1) {
        if (!forSummaryCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 2) {
        if (!forSkillCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 3) {
        if (!forEducationCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 4) {
        if (!forLangCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value == 5) {
        if (!forSocialCount()) return;
        continueCount.value++;
        return;
      }

      if (continueCount.value > 5) {
        isFinalSubmit.value = true;
      }
    }
  }

  //Common Continue For First Template
  void secondContinueClick() {
    if (continueCount.value == 0) {
      if (!forInitialCount()) return;
      continueCount.value++;
      return;
    }

    if (continueCount.value == 1) {
      if (!forSummaryCount()) return;
      continueCount.value++;
      return;
    }

    if (continueCount.value == 2) {
      if (skillController.value.text.isEmpty) {
        commonDialog("Please enter Technology");
        return;
      }

      if (toolController.value.text.isEmpty) {
        commonDialog("Please enter Tools");
        return;
      }

      if (otherSkillsController.value.text.isEmpty) {
        commonDialog("Please enter Other technology");
        return;
      }
      continueCount.value++;
      return;
    }

    if (continueCount.value == 3) {
      if (!forJobCount()) return;
      continueCount.value++;
    }

    if (continueCount.value == 4) {
      if (!forProjectCount()) return;
      continueCount.value++;
      return;
    }

    if (continueCount.value == 5) {
      if (!forEducationCount()) return;
      continueCount.value++;
    }

    if (continueCount.value == 6) {
      if (!forLangCount()) return;
      continueCount.value++;
    }

    if (continueCount.value == 7) {
      if (!forSocialCount()) return;
      continueCount.value++;
    }

    if (continueCount.value > 7) {
      isFinalSubmit.value = true;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/search_input.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/services/friend_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MakePlanPage extends StatefulWidget {
  const MakePlanPage({super.key});

  @override
  State<MakePlanPage> createState() => _MakePlanPageState();
}

class _MakePlanPageState extends State<MakePlanPage>
    with AutomaticKeepAliveClientMixin<MakePlanPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController planNameController = TextEditingController();
  TextEditingController fundController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isPublic = false;
  bool isFormValid = false;
  bool isPlanWithFund = false;
  List<Map<String, String>> selectedFriends = [];
  List<Map<String, String>> friends = [];
  List<Map<String, String>> filteredFriends = [];
  LoginResponseModel? loginDetails;

  @override
  void initState() {
    super.initState();
    _loadLoginDetails();
    _addListeners();
    _initializeData();
  }

  void _initializeData() async {
    await _loadLoginDetails();
    _loadFriendList();
  }

  Future<void> _loadLoginDetails() async {
    final details = await SharedService.loginDetails();
    setState(() {
      loginDetails = details;
    });
  }

  void _loadFriendList() async {
    try {
      String? userId = loginDetails?.id;
      List<Map<String, String>> friendsList =
          await FriendService.getFriendList(userId!);
      setState(() {
        friends = friendsList;
        filteredFriends = friends; // Initially, show all friends
      });
    } catch (e) {
      debugPrint("Failed to load friend list: $e");
    }
  }

  void _addListeners() {
    planNameController.addListener(_validateForm);
    fundController.addListener(_validateForm);
    startDateController.addListener(_validateForm);
    endDateController.addListener(_validateForm);
  }

  @override
  void dispose() {
    planNameController.dispose();
    fundController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      DateTime? startDate;
      DateTime? endDate;

      if (startDateController.text.isNotEmpty) {
        startDate = DateTime.parse(startDateController.text);
      }

      if (endDateController.text.isNotEmpty) {
        endDate = DateTime.parse(endDateController.text);
      }

      isFormValid = planNameController.text.isNotEmpty &&
          (isPlanWithFund ? fundController.text.isNotEmpty : true) &&
          startDate != null &&
          endDate != null &&
          startDate.isBefore(endDate);
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _validateForm(); // Validate form after date selection
      });
    }
  }

  void _savePlan(BuildContext context) {
    if (isFormValid) {
      // Add your save plan logic here
    }
  }

  void toggleSelection(Map<String, String> friend) {
    setState(() {
      if (selectedFriends.contains(friend)) {
        selectedFriends.remove(friend);
      } else {
        selectedFriends.add(friend);
      }
    });
  }

  void onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFriends = friends;
      } else {
        filteredFriends = friends
            .where((friend) =>
                friend['username']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showFriendSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Friends'),
              backgroundColor: Colors.amber[50],
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedFriends.isNotEmpty)
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedFriends.length,
                          itemBuilder: (context, index) {
                            final selectedFriend = selectedFriends[index];

                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: SizedBox(
                                width: 70,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        '${Config.apiURL}public/images/avatars/${selectedFriend['avatar']}',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: SvgPicture.asset(
                                            "lib/images/delete.svg",
                                            width: 16,
                                            height: 16,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedFriends.removeAt(index);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    SearchInput(onSearch: (query) {
                      setState(() {
                        if (query.isEmpty) {
                          filteredFriends = friends;
                        } else {
                          filteredFriends = friends
                              .where((friend) => friend['username']!
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        }
                      });
                    }),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredFriends.length,
                        itemBuilder: (context, index) {
                          final friend = filteredFriends[index];
                          final isSelected = selectedFriends.contains(friend);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  toggleSelection(friend);
                                });
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      '${Config.apiURL}public/images/avatars/${friend['avatar']}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          friend['username']!,
                                          style: const TextStyle(
                                              color: Color(0xFF1B1E28),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.transparent
                                            : Colors.grey,
                                        width: 2,
                                      ),
                                      color: isSelected
                                          ? const Color(0xFFFFD521)
                                          : Colors.transparent,
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 18,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: const PageStorageKey<String>('makePlan'),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: CustomBar(
        leftWidget: const BackIcon(),
        centerWidget1: const Text(
          "Make Plan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: InkWell(
          onTap: isFormValid ? () => _savePlan(context) : null,
          child: Text(
            "Done",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isFormValid ? Colors.amber : Colors.grey,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          customTextField(
                            "Plan Name",
                            const Color(0xFFF7F7F9),
                            true,
                            BorderSide.none,
                            BorderRadius.circular(14),
                            planNameController,
                            TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: customTextFieldWithDatePicker(
                                  "Start Date",
                                  const Color(0xFFF7F7F9),
                                  true,
                                  BorderSide.none,
                                  BorderRadius.circular(14),
                                  startDateController,
                                  context,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: customTextFieldWithDatePicker(
                                  "End Date",
                                  const Color(0xFFF7F7F9),
                                  true,
                                  BorderSide.none,
                                  BorderRadius.circular(14),
                                  endDateController,
                                  context,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F9),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: SwitchListTile(
                              title: const Text("Plan with fund"),
                              value: isPlanWithFund,
                              activeColor: Colors.amber,
                              onChanged: (bool value) {
                                setState(() {
                                  isPlanWithFund = value;
                                  _validateForm();
                                });
                              },
                            ),
                          ),
                          customTextField(
                            "Plan's Fund",
                            const Color(0xFFF7F7F9),
                            true,
                            BorderSide.none,
                            BorderRadius.circular(14),
                            fundController,
                            TextInputType.number,
                            enabled: isPlanWithFund,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F9),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: SwitchListTile(
                              title: const Text("This plan is public"),
                              value: isPublic,
                              activeColor: Colors.amber,
                              onChanged: (bool value) {
                                setState(() {
                                  isPublic = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _showFriendSelectionDialog,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.yellow[600],
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text("Go with friend"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
    String label,
    Color color,
    bool filled,
    BorderSide borderSide,
    BorderRadius borderRadius,
    TextEditingController controller,
    TextInputType keyboardType, {
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            filled: filled,
            fillColor: color,
            border: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: borderRadius,
            ),
          ),
          onChanged: (value) {
            setState(() {}); // This will re-render the widget
          },
        ),
      ],
    );
  }

  Widget customTextFieldWithDatePicker(
    String label,
    Color color,
    bool filled,
    BorderSide borderSide,
    BorderRadius borderRadius,
    TextEditingController controller,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: filled,
            fillColor: color,
            border: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: borderRadius,
            ),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                "lib/images/Calendar.svg",
                width: 28,
                height: 28,
              ),
              onPressed: () {
                _selectDate(context, controller);
              },
            ),
          ),
          onChanged: (value) {
            setState(() {}); // This will re-render the widget
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

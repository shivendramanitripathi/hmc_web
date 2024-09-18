import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import '../../../common_widgets/data_table.dart';
import '../../../common_widgets/summary_card.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  bool isDrawerOpen = false;
  bool isExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _dateRange;
  String? _modeOfTransportation = 'All';
  String? _status = 'All';
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double drawerWidth = isDrawerOpen ? screenWidth * 0.3 : screenWidth * 0.2;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(context),
                      SizedBox(height: isMobile ? 8 : 10),
                      _buildSummaryCards(isMobile),
                      const SizedBox(height: 10),
                      _buildSearchAndActions(isMobile),
                      const SizedBox(height: 20),
                      _buildRequestTabs(isMobile),
                      const SizedBox(height: 10),
                      const Expanded(child: DataTableWidget()),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.darBlack,
          ),
        ),
        GestureDetector(
          onTap: () async {
            await _pickDate(context);
            if (_selectedDate != null) {
              await _pickTime(context); // Open time picker after date is selected
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              color: AppColors.greyBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                Text(
                  _selectedDate != null && _selectedTime != null
                      ? '${DateFormat('d MMM yyyy').format(_selectedDate!)} at ${_selectedTime!.format(context)}'
                      : "Select Date & Time",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darBlack,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.keyboard_arrow_down_outlined, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSummaryCards(bool isMobile) {
    return Row(
      mainAxisAlignment:
      isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
      children: [
        const SummaryCard(
          iconBackgroundColor: AppColors.bgPenDing,
          imagePath: AppImages.summaryVector,
          value: '40',
          label: 'Pending Requests',
          backgroundColor: AppColors.penDingColors,
        ),
        const SummaryCard(
          imagePath: AppImages.summaryVector,
          value: '25',
          label: 'Completed Requests',
          backgroundColor: AppColors.approvalColors,
          imageSize: 20.0,
          iconBackgroundColor: AppColors.bgApproval,
        ),
        if (!isMobile)
          const SummaryCard(
            imagePath: AppImages.summaryVector,
            value: '33',
            label: 'Completed Requests',
            backgroundColor: AppColors.rejectColors,
            imageSize: 20.0,
            iconBackgroundColor: AppColors.bgReject,
          ),
        const SummaryCard(
          imagePath: AppImages.summaryVector,
          value: '435',
          label: 'Completed Requests',
          backgroundColor: AppColors.completionColors,
          imageSize: 20.0,
          iconBackgroundColor: AppColors.bgComplete,
        ),
      ],
    );
  }

  Widget _buildSearchAndActions(bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 35,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: AppColors.whiteColor),
                ),
                prefixIcon: const Icon(Icons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),
        ),
        if (!isMobile) const Spacer(),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => _toggleDropdown(context),
          child: _buildFilterButton(),
        ),
        const SizedBox(width: 16),
        _buildAddRequestButton(),
      ],
    );
  }

  Widget _buildFilterButton() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        height: 35,
        width: 85,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkMaron, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AppImages.filter, height: 16, width: 16),
            const Text(
              "Filter",
              style: TextStyle(fontSize: 14, color: AppColors.darkMaron),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddRequestButton() {
    return Container(
      height: 35,
      width: 150,
      decoration: const BoxDecoration(
          color: AppColors.darkMaron,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AppImages.addNew, width: 16, height: 16),
            const Text(
              "Add Request",
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestTabs(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: isMobile ? Axis.vertical : Axis.horizontal,
      child: Row(
        children: [
          Text("All Requests",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.red[900])),
          const SizedBox(width: 20),
          _buildTab("Inbound"),
          const SizedBox(width: 20),
          _buildTab("Outbound"),
          const SizedBox(width: 20),
          _buildTab("In-plant Material Movement"),
        ],
      ),
    );
  }

  Widget _buildTab(String label) {
    return Text(label,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4A545E)));
  }

  void _toggleDropdown(BuildContext context) {
    if (isExpanded) {
      _overlayEntry?.remove();
    } else {
      _showDropdown(context);
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _showDropdown(BuildContext context) {
    final OverlayState overlayState = Overlay.of(context);

    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 416,
        top: kToolbarHeight + 250,
        right: 80,
        child: Material(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Filter Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey),
                        onPressed: () => _toggleDropdown(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Date Range Picker
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date Range',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final DateTimeRange? selectedRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        initialDateRange: _dateRange,
                      );
                      if (selectedRange != null) {
                        setState(() {
                          _dateRange = selectedRange;
                          _dateController.text = '${DateFormat('d MMM yyyy').format(selectedRange.start)} - ${DateFormat('d MMM yyyy').format(selectedRange.end)}';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Time Picker
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Select Time',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _timeController.text = selectedTime.format(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Other Filters
                  DropdownButtonFormField<String>(
                    value: _modeOfTransportation,
                    decoration: const InputDecoration(
                      labelText: 'Mode of Transportation',
                    ),
                    items: ['All', 'Air', 'Sea', 'Land']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _modeOfTransportation = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                    ),
                    items: ['All', 'Pending', 'Completed', 'Rejected']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Apply filters and close dropdown
                        _toggleDropdown(context);
                      }
                    },
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(_overlayEntry!);
  }
}

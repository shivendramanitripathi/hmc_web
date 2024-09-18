import 'package:flutter/material.dart';

class InboundMobileEdit extends StatefulWidget {
  @override
  State<InboundMobileEdit> createState() => _InboundMobileEditState();
}

class _InboundMobileEditState extends State<InboundMobileEdit> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? _section;

  String? _invoiceValue;

  String? _modeOfTransportation;

  // Text field controllers
  final _pickupAddressController = TextEditingController();

  final _pickupPincodeController = TextEditingController();

  final _destinationAddressController = TextEditingController();

  final _destinationPincodeController = TextEditingController();

  final _approxWeightController = TextEditingController();

  final _contactPersonNameController = TextEditingController();

  final _contactPersonMobileController = TextEditingController();

  final _supplierNameController = TextEditingController();

  final _numberOfPackagesController = TextEditingController();

  final _packageDimensionsController = TextEditingController();

  final _documentPoNumberController = TextEditingController();

  final _specialInstructionsController = TextEditingController();

  final _commentsController = TextEditingController();

  final _invoiceValueController = TextEditingController();

  final _attachmentController = TextEditingController();

  // Date picker
  DateTime? _pickupDate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Inbound Request
        Text(
          'Add Inbound Request',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        // Transport Details
        Text(
          'Transport Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Section',
                            style: TextStyle(fontSize: 12),
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Select Section',
                            ),
                            value: _section,
                            onChanged: (value) {
                              setState(() {
                                _section = value as String?;
                              });
                            },
                            items: [
                              'Section 1',
                              'Section 2',
                              'Section 3',
                            ].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pickup Address',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _pickupAddressController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pickup Pincode',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _pickupPincodeController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination Address',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _destinationAddressController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination Pincode',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _destinationPincodeController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Approx Weight',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '0 kgft',
                            ),
                            controller: _approxWeightController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice Value',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _invoiceValueController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mode of Transportation ',
                            style: TextStyle(fontSize: 12),
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Select mode',
                            ),
                            value: _modeOfTransportation,
                            onChanged: (value) {
                              setState(() {
                                _modeOfTransportation = value as String?;
                              });
                            },
                            items: [
                              'Mode 1',
                              'Mode 2',
                              'Mode 3',
                            ].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pickup Date',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                              hintText: 'dd-mm-yyyy',
                            ),
                            readOnly: true,
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (date != null) {
                                setState(() {
                                  _pickupDate = date;
                                });
                              }
                            },
                            controller: TextEditingController(text: _pickupDate?.toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Pickup Details
        Text(
          'Pickup Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Person Name',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _contactPersonNameController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Person Mobile Number',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _contactPersonMobileController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supplier Name',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _supplierNameController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Package Details
        Text(
          'Package Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of Packages',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _numberOfPackagesController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Package Dimensions',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _packageDimensionsController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special Instructions',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _specialInstructionsController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Document/PO Number',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: _documentPoNumberController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attachment',
                            style: TextStyle(fontSize: 12),
                          ),
                          InkWell(
                            onTap: () {
                              // Add your file upload logic here
                              // For example, you can use the `file_picker` package to pick a file
                              // FilePickerResult? result = await FilePicker.platform.pickFile();
                            },
                            child: Container(
                              height: 40, // Adjust the height to match the other boxes
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey), // Changed the border color to a light grey
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Upload File',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.upload_file),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comments',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your comment',
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment .end,
          children: [
            ElevatedButton(
              onPressed: () {
                // Cancel button logic
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Set the button color to red
              ),
              onPressed: () {
                // Add your submit logic here
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white), // Set the text color to white
              ),
            ),
          ],
        ),
      ],
    );
  }
}
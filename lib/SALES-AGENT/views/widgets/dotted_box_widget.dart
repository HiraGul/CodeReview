import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/required_field_label.dart';

import '../../utils/app_colors.dart';
import '../../utils/message.dart';
import 'my_text.dart';

class DottedBoxWidget extends StatelessWidget {
  DottedBoxWidget(
      {super.key,
      required this.label,
      required this.text,
      required this.imagePath});
  final String label;
  final String text;
  final Function(String) imagePath;

  var fileName = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequiredFieldLabel(
          title: label,
          isRequired: false,
        ),
        6.ph,
        DottedBorder(
          dashPattern: [6.sp, 5.sp],
          color: dottedBoxColor,
          child: SizedBox(
            height: 70.sp,
            child: Center(
                child: ValueListenableBuilder(
                    valueListenable: fileName,
                    builder: (context, value, child) {
                      return TextButton(
                          onPressed: () async {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                            Icons.picture_in_picture),
                                        title: Text(
                                          "Pick From Gallery".tr(),
                                        ),
                                        onTap: () async {
                                          try {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles();

                                            if (result != null) {
                                              fileName.value =
                                                  result.files.single.name;
                                              imagePath(
                                                  result.files.single.path!);
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              if (context.mounted) {
                                                showMessage(context,
                                                    "no file selected".tr());
                                                Navigator.pop(context);
                                              }
                                            }
                                          } catch (e) {
                                            showMessage(context, e.toString());
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: Text("Pick From Camera".tr()),
                                        onTap: () async {
                                          try {
                                            final XFile? photo =
                                                await ImagePicker().pickImage(
                                                    source: ImageSource.camera);
                                            if (photo != null) {
                                              fileName.value =
                                                  photo.path.split('/').last;
                                              imagePath(photo.path);
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              if (context.mounted) {
                                                showMessage(context,
                                                    "no file selected".tr());
                                                Navigator.pop(context);
                                              }
                                            }
                                          } catch (e) {
                                            showMessage(context, e.toString());
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: MyText(
                            textAlign: TextAlign.center,
                            text: value.isEmpty ? text : value,
                            size: 14.sp,
                            color: labelColor,
                          ));
                    })),
          ),
        ),
      ],
    );
  }
}

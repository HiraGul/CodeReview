import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_form_field.dart';

import '../../../../utils/global_field_and_variable.dart';

class AddCustomerDetailComponent extends StatelessWidget {
  const AddCustomerDetailComponent({
    super.key,
    // required this.nameController,
    // required this.emailController,
    // required this.phoneController,
    // required this.secondPhoneController,
    // required this.iqamaController,
    // required this.passwordController,
    // required this.vatController,
    // required this.licenceController
  });

  // final TextEditingController nameController,
  //     emailController,
  //     phoneController,
  //     secondPhoneController,
  //     iqamaController,
  //     passwordController,
  //     vatController,
  //     licenceController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyFormField(
            isRequired: true,
            controller: nameController,
            label: "Full Name".tr(),
            keyboardType: TextInputType.name),
        22.ph,
        MyFormField(
            controller: emailController,
            label: "Email".tr(),
            isRequired: false,
            keyboardType: TextInputType.emailAddress),
        22.ph,
        MyFormField(
            isRequired: true,
            controller: phoneController,
            label: "Phone Number".tr(),
            keyboardType: TextInputType.phone),
        22.ph,
        MyFormField(
            controller: secondPhoneController,
            label: "Secondary Phone Number".tr(),
            isRequired: false,
            keyboardType: TextInputType.phone),
        22.ph,
        MyFormField(
            isRequired: true,
            controller: passwordController,
            label: "Password".tr(),
            keyboardType: TextInputType.visiblePassword),
        22.ph,
        MyFormField(
            isRequired: false,
            controller: idController,
            label: "Id Number".tr(),
            keyboardType: TextInputType.number),
        22.ph,
        MyFormField(
          controller: vatController,
          label: "VAT Number".tr(),
          isRequired: false,
          keyboardType: TextInputType.number,
        ),
        22.ph,
        MyFormField(
          isRequired: false,
          controller: licenseController,
          label: 'License Number'.tr(),
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }
}

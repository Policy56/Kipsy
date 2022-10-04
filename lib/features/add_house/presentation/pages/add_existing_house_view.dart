import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_existing_house_bloc.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_existing_house_state.dart';
import 'package:kipsy/features/add_house/presentation/model/house_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/add_task/presentation/widgets/swipe_line.dart';
import 'package:kipsy/core/widget/custom_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddExistingHouse extends StatelessWidget {
  const AddExistingHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddExistingHouseBloc(sl()),
      child: AddExistingHouseView(),
    );
  }
}

class AddExistingHouseView extends StatelessWidget {
  AddExistingHouseView({Key? key}) : super(key: key);

  Barcode? result;

  @override
  Widget build(BuildContext context) {
    final addExistingHouseBloc = context.read<AddExistingHouseBloc>();

    return WillPopScope(
      onWillPop: () async {
        addExistingHouseBloc.goBack(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.blue,
          leading: IconButton(
              onPressed: () => addExistingHouseBloc.goBack(context),
              icon: const Icon(Icons.arrow_back_ios),
              color: ThemeManager.isDark(context)
                  ? ColorManager.lightGrey
                  : ColorManager.lightGrey),
        ),
        backgroundColor: ColorManager.blue,
        body: PageHeader(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              CustomTextField(
                title: 'Add Existing Group',
                controller: addExistingHouseBloc.titleController,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                childButton: QRBtn(addExistingHouseBloc.titleController),
              ),
              const SizedBox(
                height: 10,
              ),
              const AddBtn()
            ],
          ),
        ),
      ),
    );
  }
}

class AddBtn extends StatelessWidget {
  const AddBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddExistingHouseBloc bloc = context.read<AddExistingHouseBloc>();
    return BlocConsumer<AddExistingHouseBloc, AddExistingHouseState>(
        listener: (BuildContext context, AddExistingHouseState state) async {
      if (state is AddExistingHouseLoad) {
        bloc.clearControllers();
        if (Navigator.of(context).canPop()) {
          await Future<void>.delayed(const Duration(milliseconds: 200));
          bloc.goBack(context);
        }
        bloc.showToast(context, HouseToastModel.addExistingHouseSuccess);
      } else if (state is AddExistingHouseError) {
        bloc.showToast(context, HouseToastModel.addExistingHouseError);
      }
    }, builder: (BuildContext context, AddExistingHouseState state) {
      if (state is AddExistingHouseLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddExistingHouseError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: ColorManager.white,
        padding: EdgeInsets.zero,
        onTap: () => bloc.saveExistingHouse(context),
      );
    });
  }
}

class QRBtn extends StatelessWidget {
  TextEditingController titleController;

  QRBtn(this.titleController, {Key? key}) : super(key: key);

  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    AddExistingHouseBloc bloc = context.read<AddExistingHouseBloc>();
    return BlocConsumer<AddExistingHouseBloc, AddExistingHouseState>(
        listener: (BuildContext context, AddExistingHouseState state) {},
        builder: (BuildContext context, AddExistingHouseState state) {
          if (state is AddExistingHouseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddExistingHouseError) {
            return Center(child: Text(state.msg ?? ''));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: CustomButtonChildIcon(
                childIcon: const Icon(Icons.qr_code, color: ColorManager.white),
                color: ColorManager.blue,
                fontColor: ColorManager.white,
                padding: EdgeInsets.zero,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QRViewExample(_onQRViewResult),
                  ));
                }),
          );
        });
  }

  void _onQRViewResult(Barcode? barcode) {
    titleController.text = barcode!.code ?? "";
  }
}

class QRViewExample extends StatefulWidget {
  QRViewExample(this.fctOnCreated, {Key? key}) : super(key: key);

  Function(Barcode?) fctOnCreated;

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  //formatsAllowed: const <BarcodeFormat>[BarcodeFormat.aztec],
                ),
              ),
            ],
          ),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    StreamSubscription<Barcode>? fctListen;
    fctListen = controller.scannedDataStream.listen((scanData) {
      widget.fctOnCreated(scanData);
      bool canPop = Navigator.canPop(context);
      if (canPop) {
        fctListen!.cancel();
        Navigator.of(context).pop();
      }
    });
    reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

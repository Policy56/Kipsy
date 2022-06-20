import 'package:kipsy/core/use_case/use_case.dart';

class ShareHouseUseCase /*implements UseCase<HouseEntity, HouseParams> */ {
  const ShareHouseUseCase();

  Future<void> call(HouseParams params) async {
    print("ICI ON AFFICHE UN QRCODE qui PERMET DE SHARE");
    //return _repository.deleteHouse(params.houseEntity!);
  }
}

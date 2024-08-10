import 'package:flutter/material.dart';
import 'package:spectacle/models/salle_list_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProvider extends ChangeNotifier {
  LatLngBounds? _visibleRegion;
  Size? _visibleScreenSize;
  GoogleMapController? _mapController;
  List<SalleListData> _salleList = [];

  List<SalleListData> get salleList => _salleList;

  void updateGoogleMapController(GoogleMapController mapController) async {
    _mapController = mapController;
    await _setPositionOnScreen();
    notifyListeners();
  }

  void updateScreenVisibleArea(Size size) {
    _visibleScreenSize = size;
    notifyListeners();
  }

  void updateHotelList(List<SalleListData> _list) {
    _salleList = _list;
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }

  Future _setPositionOnScreen() async {
    if (_mapController != null && _visibleScreenSize != null) {
      _visibleRegion = await _mapController?.getVisibleRegion();
      if (_visibleRegion != null) {
        var sSize = _visibleScreenSize;
        var sdl = _visibleRegion!.northeast.latitude -
            _visibleRegion!.southwest.latitude;
        var sdlg = _visibleRegion!.southwest.longitude -
            _visibleRegion!.northeast.longitude;
        if (_mapController != null) {
          for (var item in _salleList) {
            if (item.location != null) {
              var fdl =
                  _visibleRegion!.northeast.latitude - item.location!.latitude;
              var fdlg = _visibleRegion!.southwest.longitude -
                  item.location!.longitude;
              item.screenMapPin = Offset(
                  (fdlg * sSize!.width) / sdlg, (fdl * sSize.height) / sdl);
            }
          }
        }
      }
    }
  }
}

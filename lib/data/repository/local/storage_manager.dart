import 'dart:convert';

import 'package:weather/data/model/internal/unit.dart';
import 'package:weather/resources/config/ids.dart';
import 'package:weather/utils/datetime_utils.dart';
import 'package:weather/utils/log_utils.dart';
import 'package:weather/utils/shared_preferences_utils.dart';

class StorageManager {
  final SharedPreferencesUtils _spUtils;

  StorageManager(this._spUtils);

  Future<Unit> getUnit() async {
    try {
      final int? unit = await _spUtils.getInt(Ids.storageUnitKey);
      if (unit == null) {
        return Unit.metric;
      } else {
        if (unit == 0) {
          return Unit.metric;
        } else {
          return Unit.imperial;
        }
      }
    } catch (exc, stackTrace) {
      LogUtil.e("Exception: $exc stack trace: $stackTrace");
      return Unit.metric;
    }
  }

  Future<bool> saveUnit(Unit unit) async {
    try {
      LogUtil.d("Store unit $unit");
      int unitValue = 0;
      if (unit == Unit.metric) {
        unitValue = 0;
      } else {
        unitValue = 1;
      }

      final result = await _spUtils.setInt(Ids.storageUnitKey, unitValue);
      LogUtil.d("Saved with result: $result");

      return result;
    } catch (exc, stackTrace) {
      LogUtil.e("Exception: $exc stack trace: $stackTrace");
      return false;
    }
  }

  Future<bool> saveRefreshTime(int refreshTime) async {
    try {
      LogUtil.d("Save refresh time: $refreshTime");
      final result =
          await _spUtils.setInt(Ids.storageRefreshTimeKey, refreshTime);
      LogUtil.d("Saved with result: $result");
      return result;
    } catch (exc, stackTrace) {
      LogUtil.e("Exception: $exc stack trace: $stackTrace");
      return false;
    }
  }

  Future<int> getRefreshTime() async {
    try {
      int? refreshTime = await _spUtils.getInt(Ids.storageRefreshTimeKey);
      if (refreshTime == null || refreshTime == 0) {
        refreshTime = 600000;
      }
      return refreshTime;
    } catch (exc, stackTrace) {
      LogUtil.e("Exception: $exc stack trace: $stackTrace");
      return 600000;
    }
  }

  Future<bool> saveLastRefreshTime(int lastRefreshTime) async {
    try {
      LogUtil.d("Save refresh time: $lastRefreshTime");
      final result =
          await _spUtils.setInt(Ids.storageLastRefreshTimeKey, lastRefreshTime);
      LogUtil.d("Saved with result: $result");
      return result;
    } catch (exc, stackTrace) {
      LogUtil.e("Exception: $exc stack trace: $stackTrace");
      return false;
    }
  }

  Future<int> getLastRefreshTime() async {
    try {
      int? lastRefreshTime =
          await _spUtils.getInt(Ids.storageLastRefreshTimeKey);
      if (lastRefreshTime == null || lastRefreshTime == 0) {
        lastRefreshTime = DateTimeUtils.getNowTime();
      }
      return lastRefreshTime;
    } catch (exc, stackTrace) {
      LogUtil.e("Exception: $exc stack trace: $stackTrace");
      return DateTimeUtils.getNowTime();
    }
  }


}

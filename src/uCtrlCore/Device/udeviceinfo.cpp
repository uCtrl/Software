#include "udeviceinfo.h"

QVariantMap UDeviceInfo::getDeviceInfoFields() const {
    QVariantMap infoFields;

    insertValueInVariantMap(infoFields, "id", QString::number(getId()), true);

    insertValueInVariantMap(infoFields, "name", getName(), true);

    insertValueInVariantMap(infoFields, "type", QString::number(getType()), true);

    insertValueInVariantMap(infoFields, "minValue", QString::number(getMinValue()), false);

    insertValueInVariantMap(infoFields, "maxValue", QString::number(getMaxValue()), false);

    insertValueInVariantMap(infoFields, "precision", QString::number(getPrecision()), false);

    insertValueInVariantMap(infoFields, "unitLabel", getUnitLabel(), false);

    insertValueInVariantMap(infoFields, "mac", getMac(), false);

    insertValueInVariantMap(infoFields, "firmwareVersion", getFirmwareVersion(), false);

    return infoFields;
}

void UDeviceInfo::insertValueInVariantMap(QVariantMap& variantMap, QString key, QString value, bool isEditable) const {
    QVariantMap map;
    map.insert("value", QVariant(value));
    map.insert("isEditable", QVariant(isEditable));

    variantMap.insert(key, map);
}

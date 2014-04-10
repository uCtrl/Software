#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include <QAbstractListModel>

class UDeviceInfo : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(float minValue READ getMinValue WRITE setMinValue)
    Q_PROPERTY(float maxValue READ getMaxValue WRITE setMaxValue)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision)
    Q_PROPERTY(QString unitLabel READ getUnitLabel WRITE setUnitLabel)
    Q_PROPERTY(int type READ getType WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QString mac READ getMac WRITE setMac)
    Q_PROPERTY(QString firmwareVersion READ getFirmwareVersion WRITE setFirmwareVersion)

public:

    virtual QVariant data(const QModelIndex &index, int role) const { return QVariant(); }

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const { return getDeviceInfoFields().size();}

    Q_INVOKABLE QVariantMap getDeviceInfoFields() const;
    Q_INVOKABLE QList<QString> getDeviceInfoFieldsKeys() const { return getDeviceInfoFields().keys();}

    // TODO : set values
    // TODO : apply values to device (maybe)

    void insertValueInVariantMap(QVariantMap& variantMap, QString key, QString value, bool isEditable) const;

    int getId() const { return m_id; }
    QString getName() const { return m_name;}
    float getMinValue() const { return m_minValue; }
    float getMaxValue() const { return m_maxValue; }
    int getPrecision() const { return m_precision; }
    QString getUnitLabel() const { return m_unitLabel; }
    int getType() const { return m_type; }
    QString getMac() const { return m_mac; }
    QString getFirmwareVersion() const { return m_firmwareVersion; }

public slots:
    void setId(int arg) { m_id = arg;}

    void setName(QString arg)
    {
        if (m_name != arg) {
            m_name = arg;
            emit nameChanged(arg);
        }
    }

    void setMinValue(float arg) { m_minValue = arg; }
    void setMaxValue(float arg) { m_maxValue = arg; }
    void setPrecision(int arg) { m_precision = arg; }
    void setUnitLabel(QString arg) { m_unitLabel = arg; }

    void setType(int arg)
    {
        if (m_type != arg) {
            m_type = arg;
            emit typeChanged(arg);
        }
    }

    void setMac(QString arg) { m_mac = arg; }
    void setFirmwareVersion(QString arg) { m_firmwareVersion = arg; }

signals:
    void nameChanged(QString arg);
    void typeChanged(int arg);

private:
    int m_id;
    QString m_name;
    float m_minValue;
    float m_maxValue;
    int m_precision;
    QString m_unitLabel;
    int m_type;
    QString m_mac;
    QString m_firmwareVersion;
};

#endif // UDEVICEINFO_H

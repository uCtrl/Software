#ifndef UDEVICESUMMARYBUILDER_H
#define UDEVICESUMMARYBUILDER_H

#include "udevicesummary.h"

class UDeviceSummaryBuilder
{
public:
    UDeviceSummaryBuilder(UDeviceSummary* summary);
    ~UDeviceSummaryBuilder();

    void setId(int id) { m_summary->m_id = id; }
    void setIp(int ip) { m_summary->m_ip = ip; }
    void setName(std::string name) { m_summary->m_name = name; }

    UDeviceSummary* getDeviceSummary() const { return m_summary; }

private:
    UDeviceSummary* m_summary;
};

#endif // UDEVICESUMMARYBUILDER_H

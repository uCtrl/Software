#include "uuniqueidgenerator.h"
#include <time.h>
#include <sstream>
#include <iomanip>
#include <stdlib.h>

int UUniqueIdGenerator::generateUniqueId()
{
    static int idEnd = 0;
    if (idEnd > 9)
        idEnd = 0;

    time_t t = time(0);   // get time now
    struct tm * now = localtime( & t );

    int         uniqueId = 0;
                uniqueId += now->tm_mon * 100000000;
                uniqueId += now->tm_mday * 1000000;
                uniqueId += now->tm_hour * now->tm_min * now->tm_sec * 10;
                uniqueId += idEnd;

    idEnd++;
    return uniqueId;
}

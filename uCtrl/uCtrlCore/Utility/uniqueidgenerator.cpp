#include "uniqueidgenerator.h"
#include <time.h>
#include <sstream>
#include <iomanip>
#include <stdlib.h>

// ID = DDMMYYYYhhmmssxx  (xx = random number 0-99)
long long UniqueIdGenerator::GenerateUniqueId()
{
    static int idEnd = 0;

    time_t t = time(0);   // get time now
    struct tm * now = localtime( & t );

    long long   uniqueId = 0;
                uniqueId += now->tm_mday * (long long) 100000000000000;
                uniqueId += now->tm_mon  * (long long) 1000000000000;
                uniqueId += now->tm_year * (long long) 100000000;
                uniqueId += now->tm_hour * (long long) 1000000;
                uniqueId += now->tm_min  * (long long) 10000;
                uniqueId += now->tm_sec  * (long long) 100;
                uniqueId += idEnd++      * (long long) 1;
    return uniqueId;
}

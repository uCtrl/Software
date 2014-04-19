#ifndef UEMESSAGETYPE_H
#define UEMESSAGETYPE_H

enum class UEMessageType
{
    Ping = 1,
    Pong = 2,
    GetPlatformRequest = 3,
    GetPlatformResponse = 4,
    SavePlatformRequest = 5,
    SavePlatformResponse = 6
    //GetPlatformInfoRequest = 7,
    //GetPlatformInfoResponse = 8
    //...
};

#endif // UEMESSAGETYPE_H

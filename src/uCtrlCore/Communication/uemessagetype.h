#ifndef UEMESSAGETYPE_H
#define UEMESSAGETYPE_H

enum class UEMessageType
{
    Ping = 1,
    Pong = 2,
    GetPlatformRequest = 3,
    GetPlatformResponse = 4
    //GetPlatformInfoRequest = 5,
    //GetPlatformInfoResponse = 6
    //...
};

#endif // UEMESSAGETYPE_H

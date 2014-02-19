INCLUDEPATH  += $$PWD/uCtrlCore
    SOURCES      += $$PWD/uCtrlCore/*.cpp \
					$$PWD/uCtrlCore/Conditions/*.cpp \
					$$PWD/uCtrlCore/Device/*.cpp \
					$$PWD/uCtrlCore/Scenario/*.cpp \
					$$PWD/uCtrlCore/Serialization/json/*.cpp \
					$$PWD/uCtrlCore/Tasks/*.cpp
    HEADERS      += $$PWD/uCtrlCore/*.h \
					$$PWD/uCtrlCore/Conditions/*.h \
					$$PWD/uCtrlCore/Device/*.h \
					$$PWD/uCtrlCore/Scenario/*.h \
					$$PWD/uCtrlCore/Serialization/json/*.h \
					$$PWD/uCtrlCore/Tasks/*.h
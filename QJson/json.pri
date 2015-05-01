INCLUDEPATH += QJson
DEPENDPATH += $$PWD

HEADERS += \
    QJson/FlexLexer.h \
    QJson/json_parser.hh \
    QJson/json_scanner.h \
    QJson/location.hh \
    QJson/parser.h \
    QJson/parser_p.h \
    QJson/parserrunnable.h \
    QJson/position.hh \
    QJson/qjson_debug.h \
    QJson/qjson_export.h \
    QJson/qobjecthelper.h \
    QJson/serializer.h \
    QJson/serializerrunnable.h \
    QJson/stack.hh


SOURCES += \
    QJson/json_parser.cc \
    QJson/json_scanner.cc \
    QJson/json_scanner.cpp \
    QJson/parser.cpp \
    QJson/parserrunnable.cpp \
    QJson/qobjecthelper.cpp \
    QJson/serializer.cpp \
    QJson/serializerrunnable.cpp

OTHER_FILES += \
    QJson/json_parser.yy \
    QJson/json_scanner.yy

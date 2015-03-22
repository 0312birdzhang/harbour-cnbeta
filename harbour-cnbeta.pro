# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-cnbeta

VERSION = 2.0.0

DEFINES += VER=\\\"$$VERSION\\\"

QT += network webkit qml quick
CONFIG += sailfishapp

include(QJson/json.pri)

SOURCES += src/harbour-cnbeta.cpp \
    src/articleretriever.cpp \
    src/commentretriever.cpp \
    src/newslistretriever.cpp \
    src/topicretriever.cpp \
    src/utility.cpp \
    QJson/json_parser.cc \
    QJson/json_scanner.cc \
    QJson/json_scanner.cpp \
    QJson/parser.cpp \
    QJson/parserrunnable.cpp \
    QJson/qobjecthelper.cpp \
    QJson/serializer.cpp \
    QJson/serializerrunnable.cpp

OTHER_FILES += qml/harbour-cnbeta.qml \
    qml/pages/FirstPage.qml \
    qml/cnBeta/*.qml\
    qml/cnBeta/Component/*.qml\
    qml/cnBeta/gfx/*.svg\
    qml/cnBeta/gfx/*.png\
    rpm/harbour-cnbeta.spec \
    rpm/harbour-cnbeta.yaml \
    rpm/harbour-cnbeta.changes \
    translations/*.ts \
    harbour-cnbeta.desktop \
    qml/pages/API.js \
    qml/pages/NewsDetail.qml \
    qml/pages/Progress.qml \
    qml/pages/About.qml \
    qml/pages/Setting.js \
    qml/cover/icon.png \
    qml/cnBeta/Component/Notification.qml
    rpm/harbour-cnbeta.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-cnbeta-de.ts

HEADERS += \
    src/articleretriever.h \
    src/commentretriever.h \
    src/newslistretriever.h \
    src/topicretriever.h \
    src/utility.h \
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

TARGET.UID3 = 0xA0015BFD
TARGET.CAPABILITY += \
    NetworkServices \
    ReadUserData \
    WriteUserData

TARGET.EPOCHEAPSIZE = 0x40000 0x4000000

vendorinfo = "%{\"Yeatse\"}" ":\"Yeatse\""
my_deployment.pkg_prerules += vendorinfo
DEPLOYMENT += my_deployment


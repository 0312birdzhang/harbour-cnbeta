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

QT += network qml quick gui webkitwidgets webkit

CONFIG += sailfishapp


include(QJson/json.pri)

SOURCES += src/harbour-cnbeta.cpp \
    src/articleretriever.cpp \
    src/commentretriever.cpp \
    src/newslistretriever.cpp \
    src/topicretriever.cpp \
    src/utility.cpp

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
    qml/cnBeta/Component/Notification.qml \
    qml/cnBeta/InfoBanner.qml
# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-cnbeta-de.ts

HEADERS += \
    src/articleretriever.h \
    src/commentretriever.h \
    src/newslistretriever.h \
    src/topicretriever.h \
    src/utility.h

TARGET.UID3 = 0xA0015BFD
TARGET.CAPABILITY += \
    NetworkServices \
    ReadUserData \
    WriteUserData

TARGET.EPOCHEAPSIZE = 0x40000 0x4000000

vendorinfo = "%{\"Yeatse\"}" ":\"Yeatse\""
my_deployment.pkg_prerules += vendorinfo
DEPLOYMENT += my_deployment

LIBS += /usr/lib/libz.so.1

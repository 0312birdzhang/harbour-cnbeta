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


CONFIG += sailfishapp


SOURCES += src/harbour-cnbeta.cpp


OTHER_FILES += qml/harbour-cnbeta.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-cnbeta.spec \
    rpm/harbour-cnbeta.yaml \
    rpm/harbour-cnbeta.changes \
    translations/*.ts \
    harbour-cnbeta.desktop \
    qml/pages/API.js \
    qml/pages/NewsDetail.qml \
    qml/pages/About.qml \
    qml/py/__init__.py \
    qml/py/cnbeta.py \
    qml/pages/CommentsPage.qml





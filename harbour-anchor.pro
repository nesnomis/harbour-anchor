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
TARGET = harbour-anchor

CONFIG += sailfishapp

# App version
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

SOURCES += src/harbour-anchor.cpp

DISTFILES += qml/harbour-anchor.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-anchor.changes.in \
    rpm/harbour-anchor.changes.run.in \
    rpm/harbour-anchor.spec \
    rpm/harbour-anchor.yaml \
    translations/*.ts \
    harbour-anchor.desktop \
    qml/components/Dot.qml \
    qml/pages/AnchorPage.qml \
    qml/pages/AddAnchorPage.qml \
    qml/components/Compass.qml \
    qml/components/CompassCapsule.qml \
    qml/components/Settings.qml \
    qml/components/Gps.qml \
    qml/pages/SettingsPage.qml \
    qml/components/Magnetometer.qml \
    qml/pages/AboutPage.qml \
    translations/harbour-anchor-sv.ts \
    qml/components/ScreenBlank.qml \
    README.md \
    qml/pages/ChooseAnchorsPage.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-anchor-sv.ts
TRANSLATIONS += translations/harbour-anchor-da.ts

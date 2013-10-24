TEMPLATE = app
TARGET = publictransportation
TARGETPATH = /usr/bin

QT += qml quick dbus

CONFIG += link_pkgconfig

SOURCES += main.cpp

OTHER_FILES += main.qml pages/*.qml \
    pages/RealTimeStationSearchPage.qml

target.path = $$TARGETPATH

desktop.path = /usr/share/applications
desktop.files = data/publictransportation.desktop

DEPLOYMENT_PATH = /usr/share/$$TARGET
DEFINES *= DEPLOYMENT_PATH=\"\\\"\"$${DEPLOYMENT_PATH}/\"\\\"\"
qml.path = $$DEPLOYMENT_PATH
qml.files = *.qml pages cover

# translations
TS_FILE = $$OUT_PWD/publictransportation.ts
EE_QM = $$OUT_PWD/publictransportation_eng_en.qm

ts.commands += lupdate $$PWD -ts $$TS_FILE
ts.CONFIG += no_check_exist
ts.output = $$TS_FILE
ts.input = .

ts_install.files = $$TS_FILE
ts_install.path = /usr/share/translations/source
ts_install.CONFIG += no_check_exist

# should add -markuntranslated "-" when proper translations are in place (or for testing)
engineering_english.commands += lrelease -idbased $$TS_FILE -qm $$EE_QM
engineering_english.CONFIG += no_check_exist
engineering_english.depends = ts
engineering_english.input = $$TS_FILE
engineering_english.output = $$EE_QM

engineering_english_install.path = /usr/share/translations
engineering_english_install.files = $$EE_QM
engineering_english_install.CONFIG += no_check_exist

QMAKE_EXTRA_TARGETS += ts engineering_english 

PRE_TARGETDEPS += ts engineering_english

INSTALLS += target desktop qml ts_install engineering_english_install

packagesExist(qdeclarative5-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative5-boostable
} else {
   warning("qdeclarative-boostable not available; startup times will be slower")
}

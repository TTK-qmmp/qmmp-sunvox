HEADERS += decodersunvoxfactory.h \
           decoder_sunvox.h \
           sunvoxmetadatamodel.h \
           sunvoxhelper.h

SOURCES += decodersunvoxfactory.cpp \
           decoder_sunvox.cpp \
           sunvoxmetadatamodel.cpp \
           sunvoxhelper.cpp

#CONFIG += BUILD_PLUGIN_INSIDE
contains(CONFIG, BUILD_PLUGIN_INSIDE){
    include($$PWD/../../plugins.pri)
    TARGET = $$PLUGINS_PREFIX/Input/sunvox

    unix{
        target.path = $$PLUGIN_DIR/Input
        INSTALLS += target
    }
}else{
    CONFIG += warn_off plugin lib thread link_pkgconfig c++11
    TEMPLATE = lib

    unix{
        PKGCONFIG += qmmp-1

        PLUGIN_DIR = $$system(pkg-config qmmp-1 --variable=plugindir)/Input
        INCLUDEPATH += $$system(pkg-config qmmp-1 --variable=prefix)/include

        plugin.path = $${PLUGIN_DIR}
        plugin.files = lib$${TARGET}.so
        INSTALLS += plugin
    }
}

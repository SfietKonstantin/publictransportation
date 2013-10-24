#include <QLocale>
#include <QQuickView>
#include <QQmlEngine>
#include <QTranslator>
#include <QQmlComponent>
#include <QGuiApplication>

#ifdef HAS_BOOSTER
#include <MDeclarativeCache>
#endif

Q_DECL_EXPORT int main(int argc, char *argv[])
{
#ifdef HAS_BOOSTER
    QScopedPointer<QGuiApplication> app(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QQuickView> view(MDeclarativeCache::qQuickView());
#else
    QScopedPointer<QGuiApplication> app(new QGuiApplication(argc, argv));
    QScopedPointer<QQuickView> view(new QQuickView);
#endif

    QScopedPointer<QTranslator> engineeringEnglish(new QTranslator);
    engineeringEnglish->load("publictransportation_eng_en", "/usr/share/translations");
    QScopedPointer<QTranslator> translator(new QTranslator);
    translator->load(QLocale(), "publictransportation", "-", "/usr/share/translations");

    app->installTranslator(engineeringEnglish.data());
    app->installTranslator(translator.data());

    QString path;

    if (QFile::exists(QLatin1String("main.qml")))
        path = QLatin1String("main.qml");
    else
        path = QString(DEPLOYMENT_PATH) + QLatin1String("main.qml");

    view->setSource(path);
    view->showFullScreen();

    int result = app->exec();
    app->removeTranslator(translator.data());
    app->removeTranslator(engineeringEnglish.data());
    return result;
}


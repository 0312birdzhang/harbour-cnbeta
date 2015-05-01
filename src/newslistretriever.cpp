#include "newslistretriever.h"

//#include <QtDeclarative>
#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QQmlContext>
#include <QDebug>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkAccessManager>
#include <QUrlQuery>
#include "utility.h"

NewsListRetriever::NewsListRetriever(QObject *parent) :
    QObject(parent),
    m_loading(false),
    m_pageNumber(0)
{
}

NewsListRetriever::~NewsListRetriever()
{
    abortRequest();
}

bool NewsListRetriever::loading() const
{
    return m_loading;
}

void NewsListRetriever::sendRequest(const QString &type, const int &pageNumber)
{
    if (m_loading) return;

    m_loading = true;
    emit loadingChanged();

    m_type = type;
    m_pageNumber = pageNumber;

    QUrl url;
    QUrlQuery urlQuery;
    if (m_type == "all" || m_type == "realtime"){
        url.setUrl(URL_NEWSLIST);
        urlQuery.addQueryItem("type", type);
        if (pageNumber > 0){
            urlQuery.addQueryItem("page", QString::number(pageNumber));
        }
    } else {
        url.setUrl(URL_TOPICNEWS);
        urlQuery.addQueryItem("page", QString::number(pageNumber));
        urlQuery.addQueryItem("id", type);
    }
    qsrand((uint)time(NULL));
    double random = (double)qrand()/INT_MAX;
    urlQuery.addQueryItem("_", QString::number(random));
    url.setQuery(urlQuery);
    //url.setUrl(urlQuery);
    QNetworkRequest req(url);
    req.setRawHeader("user-agent", "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0)");
    req.setRawHeader("X-Requested-With", "XMLHttpRequest");
    req.setRawHeader("Referer", "http://www.cnbeta.com/");

    reply = qmlEngine(this)->networkAccessManager()->get(req);
    connect(reply.data(), SIGNAL(finished()), SLOT(slotRequestFinished()));
}

void NewsListRetriever::abortRequest()
{
    if (reply && reply->isRunning()){
        reply->abort();
    }
}

void NewsListRetriever::slotRequestFinished()
{
    reply->deleteLater();
    m_loading = false;
    emit loadingChanged();

    if (reply->error() == QNetworkReply::NoError){
        QVariantMap result = Utility::Instance()->jsonParse(reply->readAll()).toMap();
        if (result.value("status").toString() == "success"){
            QVariant list = m_type == "realtime" ? result.value("result") : result.value("result").toMap().value("list");
            emit dataReceived(m_type, list, m_pageNumber);
        }
    }
}

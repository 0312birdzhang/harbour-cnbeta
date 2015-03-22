.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块
//数据库中0:有图模式 1:无图模式
function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("cnbeta", "1.0", "setting", 10000);
}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // 如果setting表不存在，则创建一个
                    // 如果表存在，则跳过此步
                    tx.executeSql('CREATE TABLE IF NOT EXISTS cnbeta(value integer);');

                });
}

// 获取查询列表
function getSetting() {
    var isopen=0;
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM cnbeta;');
        if (rs.rows.length > 0) {
            isopen= rs.rows.item(0).value;
            console.log("VALUE:"+isopen);
        }
    });
    showNews.setting= isopen;
    //console.log("Setting:"+isopen);
}

//设置有图模式
function setPic(on_off) {
    if(on_off ===0){
        on_off = 1;
    }else{
        on_off = 0;
    }
    //console.log("入库:"+on_off);
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('update cnbeta set value = (?);', [on_off]);
        if(rs.rowsAffected > 0 ){
            showNews.setting =on_off;
            console.log("rowsAffected");
        }

    }
    );
}

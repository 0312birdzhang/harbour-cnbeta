.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块
//数据库中1:有图模式 -1:无图模式
function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("newcnbeta", "1.0", "settings", 10000);
}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // 如果setting表不存在，则创建一个
                    // 如果表存在，则跳过此步
                    tx.executeSql('CREATE TABLE IF NOT EXISTS newcnbeta(value integer);');


                });
}

function initData(){
    var db = getDatabase();
    db.transaction(function(tx) {
        tx.executeSql('insert into newcnbeta values(-1);');
    });
}
var isopen=-1;
// 获取查询列表
function getSetting() {

    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM newcnbeta;');
        if (rs.rows.length > 0) {
            isopen= rs.rows.item(0).value;
        }
        else{
            initData();
        }
    });

    return parseInt(isopen)
}

//设置有图模式
function setPic(on_off) {
    console.log("on_off:"+on_off);
    //console.log("入库:"+on_off);
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('update newcnbeta set value = ?;', [on_off]);
        if(rs.rowsAffected > 0 ){
            console.log("rowsAffected");
        }

    });
}

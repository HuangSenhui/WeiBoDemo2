//
//  SHSqliteDBTools.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/20.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHSqliteDBTools.h"

#import "SHAccountTools.h"
#import "SHStatus.h"

#import <FMDB.h>

@implementation SHSqliteDBTools

static FMDatabase *_db;

+ (void)initialize {
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [filePath stringByAppendingString:@"/statuses.db"];
    NSLog(@"%@",fileName);
    _db = [FMDatabase databaseWithPath:fileName];
    
    [_db open] ? NSLog(@"SUCCESS") : NSLog(@"FAILURE:cant open db");
    
    NSString *createTable = @"create table if not exists statuses(id INTEGER PRIMARY KEY AUTOINCREMENT,idstr text,access_token text,dic blob);";
    [_db executeUpdate:createTable] ? NSLog(@"SUCCESS") : NSLog(@"FAILURE:can't create table");
}

// 保存
+ (void)saveWithStatuses:(NSArray *)statuses {
    NSString *accessToken = [SHAccountTools account].access_token;
    for (NSDictionary *dic in statuses) {
        NSString *idstr = dic[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
        NSString *insertSTM = @"insert into statuses (idstr,access_token,dic) values (?,?,?)";
        [_db executeUpdate:insertSTM,idstr,accessToken,data] ? NSLog(@"SUCCESS") : NSLog(@"FAILURE:can't insert");
    }
    
}
// 读取
+ (NSArray *)readStatusWithParam:(NSDictionary *)param {
    NSString *accessToken = [SHAccountTools account].access_token;
    NSString *sqlSTM = [NSString stringWithFormat:@"select * from statuses where access_token = '%@' order by idstr desc limit 20",accessToken];
    /*
    if (param) {    // since_id 有参数 表示用户请求新数据，本地肯定没有
        sqlSTM =[NSString stringWithFormat:@"select * from statuses where id = -1 "];   // 0 条数据
    } else  */
    /**
     TODO:
     BUG：app 第一次打开时，控制器没有数据，每次都会向服务器请求20条数据。
     方案-：将数据库idstr 单独保存，使每次请求都是获取最新的微博数据
     方案二：启动app就查询数据库
     */
    if (param[@"max_id"]){ // max_id
        sqlSTM =[NSString stringWithFormat:@"select * from statuses where access_token = '%@' and idstr < %@ order by idstr desc limit 20",accessToken,param[@"max_id"]];
    }
    
    FMResultSet *set = [_db executeQuery:sqlSTM];
    NSMutableArray *statusArr = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dic"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        SHStatus *status = [SHStatus mj_objectWithKeyValues:dic];
        [statusArr addObject:status];
    }
    return statusArr;
}

@end

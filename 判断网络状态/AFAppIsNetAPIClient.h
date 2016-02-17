//
//  AFAppIsNetAPIClient.h
//  ChmtechIOS
//
//  Created by taixiangwang on 15/7/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

//暂时没用...
typedef enum {
    WWan = 0,
    Wifi = 1,
    NoNet = 2,
    NoKnow = 3
}netWorkType; //其他方式

#import "AFHTTPSessionManager.h"

@interface AFAppIsNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
@property (nonatomic) netWorkType isNetType;//网络类型

@end

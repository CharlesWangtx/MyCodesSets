//
//  ReachabilitySys.h
//  ChmtechIOS
//
//  Created by taixiangwang on 15/9/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//
/**
 使用方法 可以在启动程序之后调用
 - (void)reachabilityNewWork{
 // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(reachabilityChanged:)
    name: kReachabilityChangedNotification
    object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [hostReach startNotifier];
 }
 
 - (void)reachabilityChanged:(NSNotification *)note
 {
    Reachability* curReach = [noti object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
 
    switch (status)
    {
        case NotReachable:
            [ReachabilitySys sharedClientSys].myNetStatus = myNotReachable;
        break;
 
        case ReachableViaWiFi:
            [ReachabilitySys sharedClientSys].myNetStatus = myReachableViaWiFi;
        break;
        case ReachableViaWWAN:
            [ReachabilitySys sharedClientSys].myNetStatus = myReachableViaWWAN;
        break;
 
        case kReachableVia2G:
            [ReachabilitySys sharedClientSys].myNetStatus = mykReachableVia2G;
        break;
 
        case kReachableVia3G:
            [ReachabilitySys sharedClientSys].myNetStatus = mykReachableVia3G;
        break;
 
        case kReachableVia4G:
            [ReachabilitySys sharedClientSys].myNetStatus = mykReachableVia4G;
        break;
        default:
            break;
    }
 }
 
 
 */
typedef enum : NSInteger {
    myNotReachable = 0,
    myReachableViaWiFi,
    myReachableViaWWAN,
    mykReachableVia2G,
    mykReachableVia3G,
    mykReachableVia4G
} MyNetStatus;

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ReachabilitySys : NSObject

+ (instancetype)sharedClientSys;
@property (nonatomic,assign) MyNetStatus myNetStatus;

@end

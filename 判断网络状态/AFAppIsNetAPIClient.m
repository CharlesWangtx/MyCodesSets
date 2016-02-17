//
//  AFAppIsNetAPIClient.m
//  ChmtechIOS
//
//  Created by taixiangwang on 15/7/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AFAppIsNetAPIClient.h"

@interface AFAppIsNetAPIClient ()


@end

static NSString * const AFAppDotNetAPIBaseURLString = @"http://www.baidu.com";
@implementation AFAppIsNetAPIClient

+ (instancetype)sharedClient {
    
    static AFAppIsNetAPIClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[AFAppIsNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    [AFAppIsNetAPIClient sharedClient].isNetType = WWan;
                }
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    [AFAppIsNetAPIClient sharedClient].isNetType = Wifi;
                }
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                {
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    [AFAppIsNetAPIClient sharedClient].isNetType = NoNet;
                }
                    break;
                case AFNetworkReachabilityStatusUnknown:
                {
                    [AFAppIsNetAPIClient sharedClient].isNetType = NoKnow;
                }
                    break;
                default:
                    
                    break;
            }
            
        }];
        
        [_sharedClient.reachabilityManager startMonitoring];
        
    });
    
    return _sharedClient;
}


@end

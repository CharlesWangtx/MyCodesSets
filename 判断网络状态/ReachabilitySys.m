//
//  ReachabilitySys.m
//  ChmtechIOS
//
//  Created by taixiangwang on 15/9/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ReachabilitySys.h"

static ReachabilitySys *reachsys;

@implementation ReachabilitySys

+ (instancetype)sharedClientSys {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (reachsys==nil) {
    
            reachsys = [[ReachabilitySys alloc]init];
        }
    
    });
    return reachsys;
}



//-(void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
//}

@end

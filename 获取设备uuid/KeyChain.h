//
//  KeyChain.h
//  UUID
//
//  Created by tongguan on 15/11/6.
//  Copyright © 2015年 tongguan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+(void)deleteData:(NSString *)service;
@end

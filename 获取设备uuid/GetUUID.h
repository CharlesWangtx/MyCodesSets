//
//  getUUID.h
//  UUID
//
//  Created by tongguan on 15/11/6.
//  Copyright © 2015年 tongguan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUUID : NSObject
+(NSString*)getUUID;
+ (unsigned long long)murmurHash64B:( const void * )key  length:(int) len  seed:(unsigned int)seed;
@end

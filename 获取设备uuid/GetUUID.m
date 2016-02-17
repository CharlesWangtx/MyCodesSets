//
//  getUUID.m
//  UUID
//
//  Created by tongguan on 15/11/6.
//  Copyright © 2015年 tongguan. All rights reserved.
//

#import "getUUID.h"
#import "KeyChain.h"

#define myAppUUIDKEY @"mynameisfengruiwenhahawohaogaoxiaone"

@implementation GetUUID

+(NSString*)getUUID;
{
    
    if ([KeyChain load:myAppUUIDKEY]) {
        
        NSString *result = [KeyChain load:myAppUUIDKEY];
        
        return result;
    }
    else
    {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);

        //存入keyChain
        [KeyChain save:myAppUUIDKEY data:result];
        
        return result;
    }
    
    return nil;
}

//生成64位数字
+ (unsigned long long)murmurHash64B:( const void * )key  length:(int) len  seed:(unsigned int)seed
{
    const unsigned int m = 0x5bd1e995;
    const int r = 24;
    
    unsigned int h1 = seed ^ len;
    unsigned int h2 = 0;
    
    const unsigned int * data = (const unsigned int *)key;
    
    while(len >= 8)
    {
        unsigned int k1 = *data++;
        k1 *= m; k1 ^= k1 >> r; k1 *= m;
        h1 *= m; h1 ^= k1;
        len -= 4;
        
        unsigned int k2 = *data++;
        k2 *= m; k2 ^= k2 >> r; k2 *= m;
        h2 *= m; h2 ^= k2;
        len -= 4;
    }
    
    if(len >= 4)
    {
        unsigned int k1 = *data++;
        k1 *= m; k1 ^= k1 >> r; k1 *= m;
        h1 *= m; h1 ^= k1;
        len -= 4;
    }
    
    switch(len)
    {
        case 3: h2 ^= ((unsigned char*)data)[2] << 16;
        case 2: h2 ^= ((unsigned char*)data)[1] << 8;
        case 1: h2 ^= ((unsigned char*)data)[0];
            h2 *= m;
    };
    
    h1 ^= h2 >> 18; h1 *= m;
    h2 ^= h1 >> 22; h2 *= m;
    h1 ^= h2 >> 17; h1 *= m;
    h2 ^= h1 >> 19; h2 *= m;
    
    unsigned long long h = h1;
    
    h = (h << 32) | h2;
    
    return h;
}

@end

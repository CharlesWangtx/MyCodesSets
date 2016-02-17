//
//  TXPlaySound.h
//  SmallWuGuiDeFenNu
//
//  Created by taixiangwang on 15/12/11.
//  Copyright © 2015年 charles_wtx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface TXPlaySound : NSObject


/**
 *  @brief  为播放震动效果初始化
 *
 *  @return self
 */
+ (void)PlayingVibrate;


/**
 *  @brief  为播放系统音效初始化(无需提供音频文件) 声音和振动可以分开设置
 *
 *  @param resourceName 系统音效名称
 *  @param type 系统音效类型
 *
 *  @return self
 */
+ (void)PlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type isVibrate:(BOOL)isVibrate;

/**
 *  @brief  为播放系统音效初始化(无需提供音频文件)
 *
 *  @param theSoundID 系统音效id
 *
 *  @return self
 */
+ (void)PlayingSystemSoundIDWith:(SystemSoundID)theSoundID;

/**
 *  @brief  为播放特定的音频文件初始化（需提供音频文件）
 *
 *  @param filename 音频文件名（加在工程中）
 *
 *  @return self
 */
+ (void)PlayingCustomSoundFileNameWith:(NSString *)filename type:(NSString *)type isVibrate:(BOOL)isVibrate;


@end

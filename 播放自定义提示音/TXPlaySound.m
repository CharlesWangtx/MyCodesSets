//
//  TXPlaySound.m
//  SmallWuGuiDeFenNu
//
//  Created by taixiangwang on 15/12/11.
//  Copyright © 2015年 charles_wtx. All rights reserved.
//

#import "TXPlaySound.h"

@implementation TXPlaySound


+ (void)PlayingVibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


+ (void)PlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type isVibrate:(BOOL)isVibrate
{
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",resourceName,type];
//    NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
    if (path) {
        SystemSoundID theSoundID;
        OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(theSoundID);
            if (isVibrate) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }else {
            NSLog(@"Failed to create sound ");
        }
    }
}

//播放声音通过系统soundID
+ (void)PlayingSystemSoundIDWith:(SystemSoundID)theSoundID{
    if (theSoundID) {
        AudioServicesPlaySystemSound(theSoundID);
    
    }else {
        NSLog(@"Failed to create sound ");
    }
}

+ (void)PlayingCustomSoundFileNameWith:(NSString *)filename type:(NSString *)type isVibrate:(BOOL)isVibrate
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
    NSURL *fileURL = [NSURL URLWithString:path];
    if (fileURL != nil)
    {
        SystemSoundID theSoundID;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
        if (error == kAudioServicesNoError){
            AudioServicesPlaySystemSound(theSoundID);
            if (isVibrate) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            
        }else {
            NSLog(@"Failed to create sound ");
        }
    }
}


@end

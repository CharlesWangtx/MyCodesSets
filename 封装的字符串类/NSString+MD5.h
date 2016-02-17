//
//  NSString+MD5.h
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CoreLocation/CoreLocation.h>

#define kAlphaNum       @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kAlpha          @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define kNumbers        @"0123456789"
#define kNumbersPeriod  @"0123456789."
#define kCharacter      @"[@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$?^?'@#$%^&*()_+'\"]"

@interface NSString (MD5)

//判定字符串是否符合规则
-(BOOL)isStringTypeOf:(NSString*)type;

//md5加密
- (id)MD5;
//获取字符串高度
+ (float)getTextHeightWithText:(NSString*)text andFont:(UIFont *)font andWidth:(float)width;
//获取字符串宽度
+ (float)getTextWidthWithText:(NSString*)text andFont:(UIFont *)font andHeight:(float)height;
//获取字符串尺寸 spacing为行间距
+ (CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size andSpacing:(float)spacing;
//window弹出提示文字
+ (void)showTemporaryMessage:(NSString*)msg;

//转化为分钟
- (NSString*)configeTimeWithMinute;
//转化为距离米
- (NSString*)configeTimeWithMeters;
//转化为年月
- (NSString*)configeTimeWithMonth;
//转化为俗语时间描述
+ (NSString *)getUTCFormateDate:(NSString *)DateStr;
//千分符
- (NSString *)money;
//是否正确手机格式
- (BOOL)isValidateMobile;

// 3DES加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 3DES解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

//标准格式dete转字符串
+ (NSString*)stringFromFomate:(NSDate*)date;

//中文转URLEncoded
- (NSString *)URLEncodedString;
//中文转URLDEcode
+ (NSString *)decodeString:(NSString*)encodedString;

//快速转化CL2D坐标
+ (CLLocationCoordinate2D)getCoorWithLatitude:(float)latitude Longitude:(float)longitude;
//获取两点距离
+ (NSString*)getDistanceWithUser:(CLLocationCoordinate2D)usercoor Place:(CLLocationCoordinate2D)placecoor;

//根据编码获取提示语
+ (NSString*)getMsgStringWithCode:(NSString*)code;

//检索字符串
+ (NSString *)searchInString:(NSString *)string charStart:(char)start charEnd:(char)end;

//是否包含字符串
- (BOOL)hasString:(NSString *)substring;

//是否 包含/不包含 某个字符串
- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive;

//转换字符串为年月日格式
- (NSString *)toYearMonthDayStr:(NSString *)timeStr;

//标准时间转换时间戳
+ (NSString *)timeSp:(NSString *)timeStr;
//监测是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
- (NSString *)disable_emoji;

//保存从现在开始多久时间 单位为分钟
+ (void)firstOpenAppSaveToTime:(NSInteger)timeMinute saveTimeName:(NSString *)timeName;
//获取之前保存的时间和现在当前时间比较 是否过了之前保存的时间
+ (BOOL)isAppToTimeSaveTimeName:(NSString *)timeName;
//获取当前时间
+ (long long)getAppCurrentTime;

@end


@interface UILabel (colorLab)
//设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;
//设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;
//设置某段字体和颜色 不同段
- (void)setTextColor:(UIColor *)textColor colorFromIndex:(NSInteger)colorLocation colorLenth:(NSInteger)colorLength andFont:(UIFont *)font fontFromIndex:(NSInteger)fontLocation fontLength:(NSInteger)fontLength;
//设置行间距
- (void)setText:(NSString *)text withLineSpacing:(float)spacing;
//设置下划线
- (void)setUnderLineWithColor:(UIColor*)color;
//添加中划线
-(void)setMidLineWithColor:(UIColor*)color;
//设置线的颜色 和字体颜色
-(void)setMidLineWithLineColor:(UIColor*)lineColor lineLocation:(NSInteger)lineLocation lineLength:(NSInteger)lineLength textColor:(UIColor *)textColor fromIndex:(NSInteger)location textLength:(NSInteger)textLength;
@end

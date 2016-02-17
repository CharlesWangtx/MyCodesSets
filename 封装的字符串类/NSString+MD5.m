//
//  NSString+MD5.m
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import "NSString+MD5.h"
#import "YGTMBase64.h"

#define gkey            @"qianmaikeji@lx100$#365#$"
#define gIv             @"01234567"
#define PI              3.1415926

@implementation NSString (MD5)

//判定字符串是否符合规则
-(BOOL)isStringTypeOf:(NSString*)type
{
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:type] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basic = [self isEqualToString:filtered];
    
    return basic;
}

- (id)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;
}
+(float)getTextHeightWithText:(NSString*)text andFont:(UIFont *)font andWidth:(float)width
{
    if (!text) {
        return 0;
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size = CGSizeMake(width, MAXFLOAT);
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size.height;
}
+(float)getTextWidthWithText:(NSString *)text andFont:(UIFont *)font andHeight:(float)height{
    if (!text) {
        return 0;
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size = CGSizeMake(MAXFLOAT, height);
    size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;

    return size.width;
}

+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size andSpacing:(float)spacing
{
    if (!text) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    if (spacing>0)
    {
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:spacing];
        tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,paragraphStyle1,NSParagraphStyleAttributeName, nil];
    }
    
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size;
}
//分钟转换
- (NSString*)configeTimeWithMinute
{
    int mins = [self intValue];
    if (mins>60)
    {
        if (mins%60==0)
        {
            int hour = mins/60;
            return  [NSString stringWithFormat:@"%d小时",hour];
        }
        else{
            int hour = mins/60;
            int min = mins%60;
            return  [NSString stringWithFormat:@"%d小时%d分钟",hour,min];
        }
    }
    else
    {
        return  [NSString stringWithFormat:@"%d分钟",mins];
    }
}

//距离米转换
-(NSString*)configeTimeWithMeters
{
    int meter = [self intValue];
    if (meter<1000)
    {
        return [NSString stringWithFormat:@"%dm",meter];
    }
    else{
        float meters = meter/1000.0;
        return [NSString stringWithFormat:@"%0.1fkm",meters];
    }
}
//时间转换
+(NSString *)getUTCFormateDate:(NSString *)DateStr
{
    DateStr =[DateStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:DateStr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    
    if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%i%@",month,@"个月前"];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%i%@",days,@"天前"];
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%i%@",hours,@"小时前"];
    }
    else
    {
        if (minute<3)
        {
            dateContent = [NSString stringWithFormat:@"   刚刚"];
        }
        else
        {
            dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
        }
    }
    return dateContent;
    
}

//年月转换
-(NSString*)configeTimeWithMonth
{
    int months = [self intValue];
    if (months<12) {
        return [NSString stringWithFormat:@"%d个月",months];
    }
    else{
        int years = months/12;
        int month = months%12;
        return [NSString stringWithFormat:@"%d年%d个月",years,month];
    }
}

//千分符
- (NSString *)money
{
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [NSNumber numberWithDouble:[self doubleValue]];
    
    return [numFormat stringFromNumber:num];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateMobile
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(1)\\d{10}$"] evaluateWithObject:self];
    
    //[[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0-9]|17[0|6|7]|14[5])\\d{8}$"] evaluateWithObject:mobile]
}

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText
{
    NSString *key = gkey;
//    while (key.length<24)
//    {
//        key = [NSString stringWithFormat:@"%@%@",key,key];
//    }
//    key = [key stringByPaddingToLength:24 withString:key startingAtIndex:0];
//    NSLog(@"======%@",key);
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [YGTMBase64 stringByEncodingData:myData];
    return result;
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText
{
    NSString *key = gkey;
//    while (key.length<24)
//    {
//        key = [NSString stringWithFormat:@"%@%@",key,key];
//        NSLog(@"%@",key);
//    }
//    key = [key stringByPaddingToLength:24 withString:key startingAtIndex:0];
//    NSLog(@"======%@",key);
    
    NSData *encryptData = [YGTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}

//标准日期转字符串
+ (NSString*)stringFromFomate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)timeSp:(NSString *)timeStr{

//    NSString *timeStr = @"2015-01-24 10:06:55";
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [fm dateFromString:timeStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld",(long long)[date timeIntervalSince1970]];
    NSLog(@"时间戳 %@",timeSp);
    return timeSp;
}

//转换字符串为年月日格式
-(NSString *)toYearMonthDayStr:(NSString *)timeStr
{
    long long time = [timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:d]];
}


///中文转URLEncoded
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

//中文转URLDEcode
+(NSString *)decodeString:(NSString*)encodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

+(CLLocationCoordinate2D)getCoorWithLatitude:(float)latitude Longitude:(float)longitude
{
    CLLocationCoordinate2D coor;
    coor.latitude = latitude;
    coor.longitude = longitude;
    return coor;
}
+(NSString*)getDistanceWithUser:(CLLocationCoordinate2D)usercoor Place:(CLLocationCoordinate2D)placecoor
{
    if ((usercoor.latitude==0&&usercoor.longitude==0)||(placecoor.latitude==0&&placecoor.longitude==0))
    {
        return @"";
    }
    //第一个坐标
//    CLLocation *current=[[CLLocation alloc] initWithLatitude:usercoor.latitude longitude:usercoor.longitude];
    //第二个坐标
//    CLLocation *before=[[CLLocation alloc] initWithLatitude:placecoor.latitude longitude:placecoor.longitude];
    // 计算距离
//    CLLocationDistance meters=[current distanceFromLocation:before];
    
//    if (meters > 1000)
//    {
//        float m = meters/1000.0;
//        return [NSString stringWithFormat:@"%0.2fkm",m];
//    }
//    else
//    {
//        int m = (int)meters;
//        return [NSString stringWithFormat:@"%dm",m];
//    }
    return  [self LantitudeLongitudeDist:usercoor.longitude other_Lat:usercoor.latitude self_Lon:placecoor.longitude self_Lat:placecoor.latitude];
}


+(NSString *) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    double er = 6378137; // 6378700.0f;

    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    
    if (dist > 1000)
    {
        float m = dist/1000.0;
        return [NSString stringWithFormat:@"%0.2fkm",m];
    }
    else
    {
        int m = (int)dist;
        return [NSString stringWithFormat:@"%dm",m];
    }
}

+(NSString*)getMsgStringWithCode:(NSString*)code
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MessagePlist" ofType:@"plist"];
    NSDictionary *msgDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    NSString *msg = @"";
    
    if (code) {
        NSString *key = [NSString stringWithFormat:@"%@",code];
        msg = [msgDic objectForKey:key];
    }
    return msg;
}

+(void)showTemporaryMessage:(NSString*)msg
{
    if (msg==nil) {
        return;
    }
    
    float width;
    CGSize titleSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName,nil];
    titleSize =[msg boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    if (titleSize.width>200/320.0*SCREENWIDTH)
    {
        titleSize.width=200/320.0*SCREENWIDTH;
        titleSize = [msg boundingRectWithSize:CGSizeMake(titleSize.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    width = titleSize.width;
    
    float height = titleSize.height;
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    
    UILabel *promptlable=[[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-width)/2-5, window.height/2-height/2, width+10, titleSize.height+20)];
    
    promptlable.layer.cornerRadius = 4.0;
    promptlable.layer.masksToBounds = YES;
    promptlable.backgroundColor=[UIColor blackColor];
    promptlable.textAlignment=NSTextAlignmentCenter;
    promptlable.numberOfLines = 0;
    promptlable.text=msg;
    promptlable.textColor=[UIColor whiteColor];
    promptlable.font = [UIFont systemFontOfSize:14];
    
    [window addSubview:promptlable];
    [window bringSubviewToFront:promptlable];
    promptlable.alpha=0.0;
    [UIView animateWithDuration:1.5 animations:^
     {
         promptlable.alpha=0.7;
     }
                     completion:^(BOOL finished)
     {         [UIView animateWithDuration:1.5 animations:^
                {
                    promptlable.alpha=0.0 ;
                    
                } completion:^(BOOL finished)
                {
                    [promptlable removeFromSuperview];
                }];
     }];
}

//检索字符串
+ (NSString *)searchInString:(NSString *)string charStart:(char)start charEnd:(char)end
{
    int inizio = 0, stop = 0;
    
    for(int i = 0; i < [string length]; i++)
    {
        if([string characterAtIndex:i] == start)
        {
            inizio = i+1;
            i += 1;
        }
        if([string characterAtIndex:i] == end)
        {
            stop = i;
            break;
        }
    }
    
    stop -= inizio;
    
    return [[string substringFromIndex:inizio] substringToIndex:stop];
}

//是否包含字符串
- (BOOL)hasString:(NSString *)substring
{
    return [self hasString:substring caseSensitive:YES];
}

- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive
{
    if(caseSensitive)
        return [self rangeOfString:substring].location != NSNotFound;
    else
        return [self.lowercaseString rangeOfString:substring.lowercaseString].location != NSNotFound;
}

//监测是否输入了表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (NSString *)disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    
    NSString *parren = @"[.~!?:;,/'|`@#$%^&*()_+{}<>\\[\\]\\s]";
    NSRegularExpression *regex1 = [[NSRegularExpression alloc] initWithPattern:parren options:0 error:nil];
    NSString *result = [regex1 stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, modifiedString.length) withTemplate:@""];
    
    return result;
}

//保存从现在开始多久时间 单位为分钟
+ (void)firstOpenAppSaveToTime:(NSInteger)timeMinute saveTimeName:(NSString *)timeName{
    //在此保存数据 30分钟之后 打开自动定位
    NSTimeInterval times = 60*timeMinute;//分钟 单位：秒
    NSDate *nowAccDate = [NSDate date];
    NSDateFormatter *dateAccFormatter = [[NSDateFormatter alloc] init];
    [dateAccFormatter setDateFormat:@"yyyyMMddHHmmss"];

    NSDate *theAccDate = [nowAccDate initWithTimeIntervalSinceNow:times];
    NSString *toAccDateStr = [dateAccFormatter stringFromDate:theAccDate];
    [MyUserDefaults setObject:toAccDateStr forKey:timeName synchronize:YES];
    
}
//获取之前保存的时间和现在当前时间比较 是否过了之前保存的时间
+ (BOOL)isAppToTimeSaveTimeName:(NSString *)timeName{
    NSString *saveToDateStr = [MyUserDefaults objectForKey:timeName];
    if ([saveToDateStr longLongValue]<=[self getAppCurrentTime]) {
        return YES;
    }
    
    return NO;
}
//获取当前时间
+ (long long)getAppCurrentTime{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *toNowStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:nowDate]];
    return [toNowStr longLongValue];
}


@end


@implementation UILabel (colorLab)

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, length)];
    self.attributedText = str;
    
}

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (self.text.length==0) {
        return;
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.text];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(location, length)];
    self.attributedText = str;
    
}

//设置字体和颜色
- (void)setTextColor:(UIColor *)textColor colorFromIndex:(NSInteger)colorLocation colorLenth:(NSInteger)colorLength andFont:(UIFont *)font fontFromIndex:(NSInteger)fontLocation fontLength:(NSInteger)fontLength
{
    if (self.text.length==0) {
        return;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.text];
    [str addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(colorLocation, colorLength)];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(fontLocation, fontLength)];
    self.attributedText = str;
    
}

//设置行间距
-(void)setText:(NSString *)text withLineSpacing:(float)spacing
{
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:spacing];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    [self setAttributedText:attributedString1];
    //[self sizeToFit];
}

//添加下划线
-(void)setUnderLineWithColor:(UIColor*)color
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attri addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, self.text.length)];
    if (color)
    {
        [attri addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, self.text.length)];
    }
    
    [self setAttributedText:attri];
}
-(void)setMidLineWithColor:(UIColor*)color{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, self.text.length)];
    if (color)
    {
        [attri addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0, self.text.length)];
    }
    [self setAttributedText:attri];
}
//添加中划线
-(void)setMidLineWithLineColor:(UIColor*)lineColor lineLocation:(NSInteger)lineLocation lineLength:(NSInteger)lineLength textColor:(UIColor *)textColor fromIndex:(NSInteger)location textLength:(NSInteger)textLength
{

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(lineLocation, lineLength)];
    if (lineColor)
    {
        [attri addAttribute:NSStrikethroughColorAttributeName value:lineColor range:NSMakeRange(0, lineLength)];
    }
    [attri addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(location, textLength)];
    
    [self setAttributedText:attri];
    
}


@end
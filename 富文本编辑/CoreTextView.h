//
//  CoreTextView.h
//  ChmtechIOS
//
//  Created by taixiangwang on 15/9/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//
/**
 使用方法
 NSString *servicePhone = @"13760312367";
 NSString *messShow = [NSString stringWithFormat:@"车牌号粤Bxxxxx已经被他人抢先绑定了，需要帮助请拨打小蜜电话:<a href='%@'> %@</a>",servicePhone,servicePhone];
 
 [self.coreTextView removeFromSuperview];
 self.coreTextView = [[CoreTextView alloc]initWithFrame:CGRectMake(0, self.carNumView.frame.size.height + self.carNumView.frame.origin.y+20, SCREENWIDTH, 130) withLabelText:messShow hitUrl:nil];
 self.coreTextView.backgroundColor = [UIColor clearColor];
 [self.addCarNumView addSubview:self.coreTextView];
 
 */
#import <UIKit/UIKit.h>
#import "CXAHyperlinkLabel.h"
#import "NSString+CXAHyperlinkParser.h"

@interface CoreTextView : UIView

-(id)initWithFrame:(CGRect)frame withLabelText:(NSString *)coreText hitUrl:(NSString *)url;

@property (nonatomic,strong) NSString *coretext;
@property (nonatomic,strong) NSString *url;

@end

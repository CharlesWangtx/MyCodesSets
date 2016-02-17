//
//  LBTimingButton.h
//  YCPark
//
//  Created by BOBO on 15/8/17.
//  Copyright (c) 2015年 Chmtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTimingButton : UIButton

@property (nonatomic,assign) int seconds;

@property (nonatomic,assign) BOOL countUp;//是否为正计时

@property (nonatomic,assign) int endSeconds;//终点时间
@end

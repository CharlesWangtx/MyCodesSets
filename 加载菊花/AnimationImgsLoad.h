//
//  AnimationImgsLoad.h
//  ChmtechIOS
//
//  Created by taixiangwang on 15/11/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationImgsLoad : UIView

{
    UIImageView *imageView;
    UILabel *Infolabel;
}

@property (nonatomic, assign) NSString *loadtext;
@property (nonatomic, readonly) BOOL isAnimating;


-(void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;

+ (AnimationImgsLoad *)sharedInstance;
- (void)show;
- (void)dismiss;

@end

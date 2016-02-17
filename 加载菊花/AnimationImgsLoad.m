//
//  AnimationImgsLoad.m
//  ChmtechIOS
//
//  Created by taixiangwang on 15/11/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AnimationImgsLoad.h"

#define ImgViewWidth  110
#define ImgViewHeight 110

static const CGFloat WIDTH_BIG = 60;
static const CGFloat HEIGHT_BIG = 50;

@implementation AnimationImgsLoad{
    UIWindow *window;
}

static AnimationImgsLoad *animationImgsLoad;

+ (AnimationImgsLoad *)sharedInstance
{
    if (animationImgsLoad==nil) {
        animationImgsLoad = [[AnimationImgsLoad alloc]initWithFrame:CGRectMake(SCREENWIDTH/2.0-ImgViewWidth/2.0, SCREENHEIGHT/2.0-ImgViewWidth/2.0, ImgViewWidth, ImgViewHeight)];
    }
    
    return animationImgsLoad;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
        self.layer.shadowRadius = 1.0;//阴影半径，默认3
   
        
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        window = [delegate respondsToSelector:@selector(window)] ? [delegate performSelector:@selector(window)] : [[UIApplication sharedApplication] keyWindow];
        
        _isAnimating = NO;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2.0-WIDTH_BIG/2.0,20, WIDTH_BIG,HEIGHT_BIG)];
        [self addSubview:imageView];
        //设置动画帧
        imageView.animationImages=[NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"01"],
                                   [UIImage imageNamed:@"02"],
                                   [UIImage imageNamed:@"03"],
                                   [UIImage imageNamed:@"04"],
                                   [UIImage imageNamed:@"05"],
                                   [UIImage imageNamed:@"06"],
                                   nil ];
        
        
        Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom+5, ImgViewWidth, 30)];
        Infolabel.backgroundColor = [UIColor clearColor];
        Infolabel.textAlignment = NSTextAlignmentCenter;
        Infolabel.textColor = [UIColor getColorWithHex:CELLDETAILCOLOR];
        Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:13.0f];
        [self addSubview:Infolabel];
        self.layer.hidden = YES;

    }
    return self;
}



- (void)startAnimation
{
    _isAnimating = YES;
    self.layer.hidden = NO;
    [self doAnimation];
}

-(void)doAnimation{
    
    Infolabel.text = _loadtext;
    //设置动画总时间
    imageView.animationDuration = .5;
    //设置重复次数,0表示不重复
    imageView.animationRepeatCount=0;
    //开始动画
    [imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
{
    _isAnimating = NO;
    Infolabel.text = text;
    if(type){
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView stopAnimating];
            self.layer.hidden = YES;
            self.alpha = 1;
        }];
    }else{
        [imageView stopAnimating];
        [imageView setImage:[UIImage imageNamed:@"06"]];
    }
    
}


-(void)setLoadText:(NSString *)text;
{
    if(text){
        _loadtext = text;
    }
}

-(void)show{

    [window addSubview:self];
    [self setLoadText:@"飞奔加载中..."];
    [self startAnimation];
}

-(void)dismiss{
    
    [self stopAnimationWithLoadText:nil withType:YES];
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

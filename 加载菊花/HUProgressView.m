//
//  HUProgressView.m
//  CALayerDemo1
//
//  Created by jewelz on 15/4/4.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//
#define ImgViewWidth 50

#import "HUProgressView.h"
static const CFTimeInterval DURATION = 2;
static const CGFloat WIDTH_NORMAL = 22;
static const CGFloat HEIGHT_NORMAL = 22;
static const CGFloat LINE_WIDTH_NORMAL = 1;

static const CGFloat WIDTH_BIG = 40;
static const CGFloat HEIGHT_BIG = 40;
static const CGFloat LINE_WIDTH_BIG = 2;


@interface HUProgressView()

@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (strong, nonatomic) CABasicAnimation *rotateAnimation;
@property (strong, nonatomic) CABasicAnimation *strokeAnimatinStart;
@property (strong, nonatomic) CABasicAnimation *strokeAnimatinEnd;
@property (strong, nonatomic) CAAnimationGroup *animationGroup;

@end

@implementation HUProgressView{
    UIWindow *window;
}

static HUProgressView *sharedInstance;
+ (HUProgressView *)sharedInstance
{
    if (sharedInstance==nil) {
        sharedInstance = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    }
    
    return sharedInstance;
}

- (instancetype)initWithProgressIndicatorStyle:(HUProgressIndicatorStyle)style {
    
    switch (style) {
        case 0:
        {
            self =  [self initWithFrame:CGRectMake(0, 0, WIDTH_NORMAL, HEIGHT_NORMAL)];
            self.progressIndicatorStyle = HUProgressIndicatorStyleNormal;
            break;
        }
            
        case 1:
        {
            self = [self initWithFrame:CGRectMake(0, 0, WIDTH_BIG, HEIGHT_BIG)];
            self.progressIndicatorStyle = HUProgressIndicatorStyleLarge;
            self.backgroundColor = [UIColor clearColor];
            id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
            window = [delegate respondsToSelector:@selector(window)] ? [delegate performSelector:@selector(window)] : [[UIApplication sharedApplication] keyWindow];
            
            CGPoint point = CGPointMake(self.frame.size.width/2, self.frame.size.height/3);
            UILabel *msglab = [[UILabel alloc]init];
            msglab.bounds = CGRectMake(0, 0, ImgViewWidth*2, 30);
            msglab.center = CGPointMake(point.x, point.y+(ImgViewWidth+10)/2+12);
            msglab.textAlignment = NSTextAlignmentCenter;
            msglab.backgroundColor = [UIColor clearColor];
            msglab.text = @"飞奔加载中...";
            msglab.font = [UIFont systemFontOfSize:14];
            msglab.textColor = [UIColor getColorWithHex:YELLOWCOLOR];
            [self addSubview:msglab];
            
            
        }
            break;
        
    }
    return self;
}

- (instancetype)init {
    
    return [self initWithFrame:CGRectMake(0, 0, WIDTH_NORMAL, HEIGHT_NORMAL)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGPoint point = CGPointMake(self.frame.size.width/2, self.frame.size.height/3);
        UIImageView *mainImgView = [[UIImageView alloc]init];
        mainImgView.bounds = CGRectMake(0, 0, ImgViewWidth+60, ImgViewWidth+60);
        mainImgView.center = CGPointMake(point.x, point.y+10);
        mainImgView.backgroundColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:62/255.0 alpha:.6];
        mainImgView.layer.cornerRadius = 10;
        [self.layer addSublayer:mainImgView.layer];
        
        [self.layer addSublayer:self.progressLayer];
        
    }
    return self;
}


- (void)setProgressIndicatorStyle:(HUProgressIndicatorStyle)progressIndicatorStyle {
    _progressIndicatorStyle = progressIndicatorStyle;
    switch (_progressIndicatorStyle) {
        case 0:
            break;
        case 1:
            {
                self.progressLayer.bounds = CGRectMake(0, 0, WIDTH_BIG, HEIGHT_BIG);
                self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH_BIG/2, HEIGHT_BIG/2) radius:(WIDTH_BIG-LINE_WIDTH_BIG) /2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES].CGPath;
                self.progressLayer.lineWidth = LINE_WIDTH_BIG;
            }

            break;
            
        default:
            break;
    }
}

//- (void)setStrokeColor:(UIColor *)strokeColor {
//    _strokeColor = strokeColor;
//    self.progressLayer.strokeColor = strokeColor.CGColor;
//}

#pragma mark - 初始化--菊花
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.bounds = CGRectMake(0, 0, WIDTH_NORMAL, HEIGHT_NORMAL);
        _progressLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH_NORMAL/2, HEIGHT_NORMAL/2) radius:(WIDTH_NORMAL-LINE_WIDTH_NORMAL) /2 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = LINE_WIDTH_NORMAL;
        _progressLayer.strokeColor = [UIColor getColorWithHex:YELLOWCOLOR].CGColor;
        _progressLayer.strokeEnd = 0;
        _progressLayer.strokeStart = 0;
        _progressLayer.lineCap = kCALineCapRound;
    }
    return _progressLayer;
}


- (CABasicAnimation *)rotateAnimation {
    if (!_rotateAnimation) {
        _rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _rotateAnimation.fromValue = @0;
        _rotateAnimation.toValue = @(2*M_PI);
        _rotateAnimation.duration = DURATION/2;
        _rotateAnimation.repeatCount = HUGE;
        _rotateAnimation.removedOnCompletion = NO;
    }
    return _rotateAnimation;
}

- (CABasicAnimation *)strokeAnimatinStart {
    if (!_strokeAnimatinStart) {
        _strokeAnimatinStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        _strokeAnimatinStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _strokeAnimatinStart.duration = DURATION/2;
        _strokeAnimatinStart.fromValue = @0;
        _strokeAnimatinStart.toValue = @0.95;
        _strokeAnimatinStart.beginTime = 1;
        _strokeAnimatinStart.removedOnCompletion = NO;
        _strokeAnimatinStart.fillMode = kCAFillModeForwards;
        _strokeAnimatinStart.repeatCount = HUGE;
    }
    return _strokeAnimatinStart;
}

- (CABasicAnimation *)strokeAnimatinEnd {
    if (!_strokeAnimatinEnd) {
        _strokeAnimatinEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeAnimatinEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _strokeAnimatinEnd.duration = DURATION;
        _strokeAnimatinEnd.fromValue = @0;
        _strokeAnimatinEnd.toValue = @0.95;
        _strokeAnimatinEnd.removedOnCompletion = NO;
        _strokeAnimatinEnd.fillMode = kCAFillModeForwards;
        _strokeAnimatinEnd.repeatCount = HUGE;
    }
    return _strokeAnimatinEnd;
}

- (CAAnimationGroup *)animationGroup {
    if (!_animationGroup) {
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.animations = @[self.strokeAnimatinStart, self.strokeAnimatinEnd];
        _animationGroup.repeatCount = HUGE;
        _animationGroup.duration = DURATION;
        
    }
    return _animationGroup;
}

- (void)startProgressAnimating {
    [self.progressLayer addAnimation:self.animationGroup forKey:@"group"];
    [self.progressLayer addAnimation:self.rotateAnimation forKey:@"rotate"];

}

- (void)stopProgressAnimating {
    if (self.rotateAnimation && self.animationGroup) {
        [self.progressLayer removeAllAnimations];
    }
}


-(void)show{
    self.center = window.center;
    [window addSubview:self];
    
    [self startProgressAnimating];
}

-(void)dismiss{
    [self stopProgressAnimating];
    
    [self removeFromSuperview];
}

@end

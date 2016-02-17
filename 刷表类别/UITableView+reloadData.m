//
//  UITableView+Reloaddata.m
//  CDF
//
//  Created by apple on 15-3-3.
//  Copyright (c) 2015年 Chmtech. All rights reserved.
//

#import "UITableView+reloadData.h"

#define TAG 2015

@interface TableViewMSGView : UIView
@property (nonatomic,strong) void (^backImageClick)(void);

@property (nonatomic,strong) UIImageView *backImgV;
@property (nonatomic,strong) UILabel *msgLab;
@property (nonatomic,strong) UILabel *msg2Lab; //认证的车场 暂无搜索记录

@end

@implementation TableViewMSGView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        backView.bounds = CGRectMake(0, 0, SCREENWIDTH, 140);
        backView.center = CGPointMake(self.center.x, self.height*0.43);
        
        
        _backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-75, 0, 150, 150)];
        _backImgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backImgClick)];
        [_backImgV addGestureRecognizer:tap];
        
        _msgLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _backImgV.frame.origin.y+_backImgV.frame.size.height+10,SCREENWIDTH-20, 20)];
        _msgLab.textColor = [UIColor lightGrayColor];
        _msgLab.font = [MyUserService shareService].textDetailFont;
        _msgLab.textAlignment = NSTextAlignmentCenter;
        
        _msg2Lab = [[UILabel alloc]initWithFrame:CGRectMake(_msgLab.frame.origin.x, _msgLab.bottom, _msgLab.width, _msgLab.height)];
        _msg2Lab.textColor = [UIColor lightGrayColor];
        _msg2Lab.font = [MyUserService shareService].textDetailFont;
        _msg2Lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:backgroundView];
        [backView addSubview:_backImgV];
        [backView addSubview:_msgLab];
        [backView addSubview:_msg2Lab];
        
        [self addSubview:backView];
    }
    return self;
}

-(void)backImgClick
{
    if (self.backImageClick)
    {
        self.backImageClick();
    }
    
}
@end


@implementation UITableView (reloadData)

-(void)reloadDataWithAry:(NSArray*)valueAry ImgName:(NSString *)imgName MSGTitle:(NSString*)msg MSG2Title:(NSString *)msg2Str MSGView:(UIView*)msgView
{
    if (valueAry.count==0)
    {
        for (UIView *vi in self.subviews)
        {
            //已存在提示页面，则重新赋值msg，直接显示
            if (vi.tag == TAG)
            {
                TableViewMSGView *vi = (TableViewMSGView*)[self viewWithTag:TAG];
                self.scrollEnabled = NO;
                
                vi.backImgV.image = imgName?[UIImage imageNamed:imgName]:[UIImage imageNamed:@"no_alluse"];
                vi.backImgV.frame = CGRectMake(SCREENWIDTH/2-vi.backImgV.image.size.width/2, 0, vi.backImgV.image.size.width, vi.backImgV.image.size.height);
                vi.msgLab.frame = CGRectMake(10, vi.backImgV.frame.origin.y+vi.backImgV.frame.size.height+12,SCREENWIDTH-20, 20);
                vi.msgLab.text = msg ? msg : @"";
                //是否为认证车场列表
                vi.msg2Lab.frame = CGRectMake(10, vi.msgLab.bottom+5,SCREENWIDTH-20, 20);
                vi.msg2Lab.text = msg2Str;
                
                [self reloadData];
                return;
            }
        }
        
        if (msgView)
        {
            msgView.tag = TAG;
            self.scrollEnabled = NO;
            [self addSubview:msgView];
        }
        else
        {
            TableViewMSGView *msgView = [[TableViewMSGView alloc]initWithFrame:CGRectMake(0, [self rectForHeaderInSection:0].size.height, self.frame.size.width, self.frame.size.height-[self rectForHeaderInSection:0].size.height)];
            self.scrollEnabled = NO;
            msgView.tag = TAG;
            
            msgView.backImgV.image = imgName?[UIImage imageNamed:imgName]:[UIImage imageNamed:@"no_alluse"];
            msgView.backImgV.frame = CGRectMake(SCREENWIDTH/2-msgView.backImgV.image.size.width/2, 0, msgView.backImgV.image.size.width, msgView.backImgV.image.size.height);
            
            msgView.msgLab.frame = CGRectMake(10, msgView.backImgV.frame.origin.y+msgView.backImgV.frame.size.height+12,SCREENWIDTH-20, 20);
            msgView.msgLab.text = msg ? msg : @"";
            
            //是否为认证车场列表
            msgView.msg2Lab.frame = CGRectMake(10, msgView.msgLab.bottom+5,SCREENWIDTH-20, 20);
            msgView.msg2Lab.text = msg2Str;
            
            [self addSubview:msgView];
        }
        
    }
    else
    {
        for (UIView *vi in self.subviews) {
            if (vi.tag == TAG)
            {
                [vi removeFromSuperview];
            }
        }
        self.scrollEnabled = YES;
    }
    [self reloadData];
}

-(void)showErrorWithArray:(NSArray*)valueAry ImgName:(NSString *)imgName MSGTitle:(NSString*)msg Click:(void (^)())clicked
{
    if (valueAry.count==0)
    {
        for (UIView *vi in self.subviews)
        {
            //已存在提示页面，则重新赋值msg，直接显示
            if (vi.tag == TAG)
            {
                TableViewMSGView *vi = (TableViewMSGView*)[self viewWithTag:TAG];
                
                vi.backImgV.image = [UIImage imageNamed:@"no_net"];
                vi.backImgV.frame = CGRectMake(SCREENWIDTH/2-vi.backImgV.image.size.width/2, 0, vi.backImgV.image.size.width, vi.backImgV.image.size.height);
                
                vi.msgLab.frame = CGRectMake(10, vi.backImgV.frame.origin.y+vi.backImgV.frame.size.height+10,SCREENWIDTH-20, 20);
                vi.msgLab.text = msg ? msg : @"加载失败 戳下图标再试试";
                vi.msg2Lab.text = nil;
                vi.backImageClick = clicked;
                return;
            }
        }
        
        TableViewMSGView *msgView = [[TableViewMSGView alloc]initWithFrame:CGRectMake(0, [self rectForHeaderInSection:0].size.height, self.frame.size.width, self.frame.size.height-[self rectForHeaderInSection:0].size.height)];
        msgView.tag = TAG;
        
        msgView.backImgV.image = [UIImage imageNamed:@"no_net"];
        msgView.backImgV.frame = CGRectMake(SCREENWIDTH/2-msgView.backImgV.image.size.width/2, 0, msgView.backImgV.image.size.width, msgView.backImgV.image.size.height);
        
        msgView.msgLab.frame = CGRectMake(10, msgView.backImgV.frame.origin.y+msgView.backImgV.frame.size.height+10,SCREENWIDTH-20, 20);
        msgView.msgLab.text = msg ? msg : @"加载失败 戳下图标再试试";
        msgView.msg2Lab.text = nil;
        msgView.backImageClick = clicked;
        [self addSubview:msgView];
    }
}

-(void)endRefreshing
{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

@end


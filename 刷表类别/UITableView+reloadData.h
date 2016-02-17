//
//  UITableView+Reloaddata.h
//  CDF
//
//  Created by apple on 15-3-3.
//  Copyright (c) 2015年 Chmtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableView (reloadData)

//自定义无数据页面,提醒文字和页面可为空
-(void)reloadDataWithAry:(NSArray*)valueAry ImgName:(NSString *)imgName MSGTitle:(NSString*)msg MSG2Title:(NSString *)msg2Str MSGView:(UIView*)msgView;

//网络请求失败页面
-(void)showErrorWithArray:(NSArray*)valueAry ImgName:(NSString *)imgName MSGTitle:(NSString*)msg Click:(void (^)())clicked;

-(void)endRefreshing;
@end


//
//  ErWeiMaScanViewController.h
//  SmallWuGuiDeFenNu
//
//  Created by taixiangwang on 15/12/15.
//  Copyright © 2015年 charles_wtx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErWeiMaScanViewController : UIViewController

@property (nonatomic,strong) void (^clickBlock)(ErWeiMaScanViewController *erWeiScan);
/**
 * 二维码扫描结果
 */
@property (nonatomic,strong) NSString *erWeiScanStr;

@end

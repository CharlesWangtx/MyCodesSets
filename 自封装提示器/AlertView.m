//
//  AlertView.m
//  QQReader
//
//  Created by friends on 15/1/27.
//  Copyright (c) 2015年 friends. All rights reserved.
//

#import "AlertView.h"
#import "Toast.h"
@implementation AlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static UIAlertView *sAlert = nil;
static NSString *cancelButtonTitle = nil;
+(void)alert:(NSString *)title message:(NSString *)message{
    cancelButtonTitle = @"取消";
    if (sAlert) {
        return;
    }
    if (message == nil) {
        [Toast showWithText:title];
    }
    else {

        sAlert = [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:cancelButtonTitle
                                  otherButtonTitles:nil];
        sAlert.delegate = self;
        [sAlert show];

    }

}
@end

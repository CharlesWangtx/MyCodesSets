//
//  UILabel+FixSizeLabel.m
//  cyx_app_picc
//
//  Created by a on 15/3/3.
//
//
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#import "UILabel+FixSizeLabel.h"

@implementation UILabel (FixSizeLabel)

-(void)suitSize:(CGSize)size{
    self.numberOfLines = 0;
    CGSize reSize ;
    if (isIOS7) {
        NSDictionary *dict = @{NSFontAttributeName:self.font};
        CGRect rect = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        reSize = rect.size;
    }else{
        CGSize tempSize = [self.text sizeWithFont:self.font constrainedToSize:size];
        reSize = tempSize;
    }
    CGRect frame = self.frame;
    frame.size.width = ceilf(reSize.width);
    frame.size.height = ceilf(reSize.height);
    //把计算好的frame给现在的label的frame
    self.frame = frame;
    
}
@end

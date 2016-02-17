//
//  CoreTextView.m
//  ChmtechIOS
//
//  Created by taixiangwang on 15/9/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CoreTextView.h"

@interface CoreTextView ()

@property (nonatomic,strong) CXAHyperlinkLabel *label;

- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
                               URLRanges:(NSArray *__autoreleasing *)outURLRanges andText:(NSString *)HTMLText url:(NSString *)urlStr;
@end

@implementation CoreTextView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpViewText:_coretext url:_url];
    }
    return self;
    
}

-(id)initWithFrame:(CGRect)frame withLabelText:(NSString *)coreText hitUrl:(NSString *)url{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViewText:coreText url:url];
    }
    
    return self;
}

-(void)setUpViewText:(NSString *)text url:(NSString *)url{
    
    NSArray *URLs;
    NSArray *URLRanges;
    NSAttributedString *as = [self attributedString:&URLs URLRanges:&URLRanges andText:text url:url];
    _label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH-40, 90)];
    _label.numberOfLines = 0;
    _label.backgroundColor = [UIColor whiteColor];
    _label.attributedText = as;
    [_label setURLs:URLs forRanges:URLRanges];
    
    
    _label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
        
        NSString *callNumber = [URL absoluteString];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", callNumber]];
        
        XWAlterview *xw = [[XWAlterview alloc]initWithTitle:@"客服电话" contentText:callNumber leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        xw.alertContentLabel.textColor = [UIColor getColorWithHex:CELLTEXTCOLOR];
        xw.alertContentLabel.font = [UIFont systemFontOfSize:25];
        xw.rightBlock = ^{
            [[UIApplication sharedApplication] openURL:url];
        };
        [xw show];
        
    };
    _label.URLLongPressHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
        
        
    };
    [self addSubview:_label];
}


//- (void)viewWillLayoutSubviews
//{
//    CGFloat margin = 10.;
//    CGSize size = CGRectInset(self.bounds, margin, margin).size;
//    size.height = INT16_MAX;
//    CGSize labelSize = [_label sizeThatFits:size];
//    labelSize.width = size.width;
//    _label.frame = (CGRect){CGPointMake(margin, margin), labelSize};
//
//}

#pragma mark - privates
- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
                               URLRanges:(NSArray *__autoreleasing *)outURLRanges andText:(NSString *)HTMLText url:(NSString *)urlStr
{
    NSArray *URLs;
    NSArray *URLRanges;
    UIColor *color = [UIColor darkGrayColor];
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableParagraphStyle *mps = [[NSMutableParagraphStyle alloc] init];
    mps.lineSpacing = ceilf(font.pointSize * .5);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSString *str = [NSString stringWithHTMLText:HTMLText baseURL:[NSURL URLWithString:urlStr] URLs:&URLs URLRanges:&URLRanges];
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:str attributes:@
                                      {
                                          NSForegroundColorAttributeName : color,
                                          NSFontAttributeName            : font,
                                          NSParagraphStyleAttributeName  : mps,
                                          NSShadowAttributeName          : shadow,
                                      }];
    [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        [mas addAttributes:@
         {
             NSForegroundColorAttributeName : [UIColor getColorWithHex:YellowTextColor],
             NSUnderlineStyleAttributeName  : @(NSUnderlineStyleSingle)
         } range:[obj rangeValue]];
    }];
    
    *outURLs = URLs;
    *outURLRanges = URLRanges;
    
    return [mas copy];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

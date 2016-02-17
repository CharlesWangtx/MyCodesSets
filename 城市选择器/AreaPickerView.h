//
//  AreaPickerView.h
//  ChmtechIOS
//
//  Created by taixiangwang on 15/8/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

typedef enum {
    HZAreaPickerWithStateAndCity,
    HZAreaPickerWithStateAndCityAndDistrict
} HZAreaPickerStyle;

@class AreaPickerView;
@protocol AreaPickerViewDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(AreaPickerView *)picker;

@end

@interface AreaPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
@property (assign, nonatomic) id <AreaPickerViewDelegate> delegate;
@property (strong, nonatomic)  UIPickerView *locatePicker;

@property (strong, nonatomic) Location *locate;
@property (nonatomic) HZAreaPickerStyle pickerStyle;

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id <AreaPickerViewDelegate>)delegate;
- (void)show;
- (void)cancelPicker;

@end

//
//  CMCColorPickerView.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CMCColorPickerViewDidChangeBlock)(UIColor *color);

typedef enum {
    CMCColorPickerViewModeRGB = 0,
    CMCColorPickerViewModeHSB = 1,
    kCMCColorPickerViewModeCount = 2
} CMCColorPickerViewMode;

@interface CMCColorPickerView : UIView

@property (nonatomic) CMCColorPickerViewMode colorMode;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) CMCColorPickerViewDidChangeBlock colorChangedBlock;

@end

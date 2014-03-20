//
//  CMCColorEditViewController.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCEditViewController.h"

@class CMCColorTweakDescriptor;

typedef enum {
    CMCColorModeRGB,
    CMCColorModeHSB,
} CMCColorMode;

@interface CMCColorEditViewController : CMCEditViewController

@property (nonatomic, strong) CMCColorTweakDescriptor *tweakDescriptor;
@property (nonatomic) CMCColorMode colorMode;

@end

//
//  CMCNumericEditViewController.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCEditViewController.h"

@class CMCNumericTweakDescriptor;

@interface CMCNumericEditViewController : CMCEditViewController

@property (nonatomic, strong) CMCNumericTweakDescriptor *tweakDescriptor;
@property (nonatomic, strong) UITextField *numberField;

@end
    
//
//  CMCStringEditViewController.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCEditViewController.h"

@class CMCStringTweakDescriptor;

@interface CMCStringEditViewController : CMCEditViewController

@property (nonatomic, strong) UITextView *stringTextView;
@property (nonatomic, strong) CMCStringTweakDescriptor *tweakDescriptor;

@end

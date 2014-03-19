//
//  CMCFontEditViewController.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCEditViewController.h"

@class CMCFontTweakDescriptor;

@interface CMCFontEditViewController : CMCEditViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CMCFontTweakDescriptor *tweakDescriptor;

@end

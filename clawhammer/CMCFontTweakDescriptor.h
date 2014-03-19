//
//  CMCFontTweakDescriptor.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCTweakDescriptor.h"
#import <UIKit/UIKit.h>

@interface CMCFontTweakDescriptor : CMCTweakDescriptor
@property (nonatomic) CGFloat minimumPointSize;
@property (nonatomic) CGFloat maximumPointSize;
@end

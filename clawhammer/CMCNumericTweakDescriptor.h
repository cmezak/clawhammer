//
//  CMCNumericTweakDescriptor.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCTweakDescriptor.h"

extern NSString * const CMCNumericTweakPrecisionInteger;
extern NSString * const CMCNumericTweakPrecisionFloat;
extern NSString * const CMCNumericTweakPrecisionDouble;

@interface CMCNumericTweakDescriptor : CMCTweakDescriptor

@property (nonatomic) NSNumber * minimumValue;
@property (nonatomic) NSNumber * maximumValue;
@property (nonatomic) NSString * precision;

@end

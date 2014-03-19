//
//  CMCTweakDescriptor.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const CMCClawhammerTweakDidChangeValueNotification;
extern NSString * const CMCClawhammerTweakValueKey;
extern NSString * const CMCClawhammerTweakNameKey;

@interface CMCTweakDescriptor : NSObject

@property (nonatomic, strong) NSString *tweakName;
@property (nonatomic, strong) NSString *tweakDescription;
@property (nonatomic, strong) NSString *tweakValueDescription;
@property (nonatomic, strong) id defaultValue;
@property (nonatomic, strong) id tweakValue;

@end


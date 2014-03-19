//
//  CMCTweakDescriptor.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCTweakDescriptor.h"

NSString * const CMCClawhammerTweakDidChangeValueNotification = @"CMCClawhammerTweakDidChangeValueNotification";
NSString * const CMCClawhammerTweakValueKey = @"CMCClawhammerTweakValueKey";
NSString * const CMCClawhammerTweakNameKey = @"CMCClawhammerTweakNameKey";

@implementation CMCTweakDescriptor

@synthesize tweakValue = _tweakValue;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // ignore undefined keys
}

- (id)tweakValue
{
    if (_tweakValue == nil) return self.defaultValue;
    
    return _tweakValue;
}

- (NSString *)tweakValueDescription
{
    return [self.tweakValue description];
}

- (void)setTweakValue:(id)tweakValue
{
    id oldValue = _tweakValue;
    _tweakValue = tweakValue;
    if (![tweakValue isEqual:oldValue]) [self sendChangeNotification];
}

- (void)sendChangeNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CMCClawhammerTweakDidChangeValueNotification
                                                        object:nil
                                                      userInfo:@{CMCClawhammerTweakValueKey : self.tweakValue,
                                                                 CMCClawhammerTweakNameKey : self.tweakName}];
}

@end

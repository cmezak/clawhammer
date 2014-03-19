//
//  CMCFontTweakDescriptor.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCFontTweakDescriptor.h"

@implementation CMCFontTweakDescriptor

- (void)setDefaultValue:(id)defaultValue
{
    NSString *fontString = defaultValue;
    NSArray *components = [fontString componentsSeparatedByString:@":"];
    UIFont *font = [UIFont fontWithName:[components firstObject] size:[[components lastObject] floatValue]];
    [super setDefaultValue:font];
}

- (NSString *)tweakValueDescription
{
    return [NSString stringWithFormat:@"%@ : %@pt", [self.tweakValue familyName], @([self.tweakValue pointSize])];
}

- (CGFloat)minimumPointSize
{
    return 5.f;
}

- (CGFloat)maximumPointSize
{
    return 32.f;
}

@end

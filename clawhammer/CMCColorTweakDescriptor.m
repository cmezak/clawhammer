//
//  CMCColorTweakDescriptor.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCColorTweakDescriptor.h"

@implementation CMCColorTweakDescriptor

- (void)setDefaultValue:(id)defaultValue
{
    NSString *rgbaString = (NSString *)defaultValue;
    NSArray *numbers = [rgbaString componentsSeparatedByString:@","];
    
    UIColor *color;
    
    if (numbers.count == 1) // grayscale
    {
        color = [UIColor colorWithWhite:[numbers[0] floatValue]
                                  alpha:1.f];
    }
    else if (numbers.count == 2) // grayscale + alpha
    {
        color = [UIColor colorWithWhite:[numbers[0] floatValue]
                                  alpha:[numbers[1] floatValue]];
    }
    else if (numbers.count == 3) // rgb
    {
        color = [UIColor colorWithRed:[numbers[0] floatValue]/255.f
                                green:[numbers[1] floatValue]/255.f
                                 blue:[numbers[2] floatValue]/255.f
                                alpha:1.f];
    }
    else if (numbers.count == 4) // rgb + a
    {
        color = [UIColor colorWithRed:[numbers[0] floatValue]/255.f
                                green:[numbers[1] floatValue]/255.f
                                 blue:[numbers[2] floatValue]/255.f
                                alpha:[numbers[3] floatValue]];
    }
    
    [super setDefaultValue:color];
}

@end

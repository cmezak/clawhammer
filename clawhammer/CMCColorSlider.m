//
//  CMCColorSlider.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCColorSlider.h"

@implementation CMCColorSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self updateForTouchLocation:[[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self updateForTouchLocation:[[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self updateForTouchLocation:[[touches anyObject] locationInView:self]];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self updateForTouchLocation:[[touches anyObject] locationInView:self]];
}

- (void)updateForTouchLocation:(CGPoint)location
{
    self.value = location.x / CGRectGetWidth(self.bounds);
}

- (void)setValue:(CGFloat)value
{
    _value = value;
    
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    [_backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    backgroundView.frame = self.bounds;
    [self insertSubview:backgroundView atIndex:0];
}

@end

//
//  CMCColorPickerView.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCColorPickerView.h"

#import "CMCColorSlider.h"

@interface CMCColorPickerView ()

@property (nonatomic, strong) UISegmentedControl *colorModeControl;

@property (nonatomic, strong) CMCColorSlider *topSlider;
@property (nonatomic, strong) CMCColorSlider *middleSlider;
@property (nonatomic, strong) CMCColorSlider *bottomSlider;
@property (nonatomic, strong) CMCColorSlider *alphaSlider;

@property (nonatomic, strong) UITextField *topField;
@property (nonatomic, strong) UITextField *middleField;
@property (nonatomic, strong) UITextField *bottomField;
@property (nonatomic, strong) UITextField *alphaField;

@property (nonatomic, strong) UIView *saturationBackgroundView;
@property (nonatomic, strong) UIView *hueBackgroundView;
@property (nonatomic, strong) UIView *brightnessBackgroundView;

@end

@implementation CMCColorPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CMCColorPickerView_setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self CMCColorPickerView_setup];
}

- (void)CMCColorPickerView_setup
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.colorModeControl = [[UISegmentedControl alloc] initWithItems:@[@"RGB", @"HSB"]];
    [self addSubview:self.colorModeControl];
    [self.colorModeControl addTarget:self action:@selector(colorModeControlChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.topSlider = [CMCColorSlider new];
    self.middleSlider = [CMCColorSlider new];
    self.bottomSlider = [CMCColorSlider new];
    self.alphaSlider = [CMCColorSlider new];
    
    self.topField = [UITextField new];
    self.middleField = [UITextField new];
    self.bottomField = [UITextField new];
    self.alphaField = [UITextField new];
    
    [self addSubview:self.topSlider];
    [self addSubview:self.middleSlider];
    [self addSubview:self.bottomSlider];
    
    [self addSubview:self.topField];
    [self addSubview:self.middleField];
    [self addSubview:self.bottomField];
    
    self.colorMode = CMCColorPickerViewModeHSB;
}

- (void)layoutSubviews
{
    CGFloat itemHeight      = CGRectGetHeight(self.bounds) * 0.25f;
    CGFloat fieldWidth      = CGRectGetWidth(self.bounds) * 0.25f;
    CGFloat sliderWidth     = CGRectGetWidth(self.bounds) - fieldWidth;
    
    self.topSlider.frame    = CGRectMake(0.f, 0.f, sliderWidth, itemHeight);
    self.topField.frame     = CGRectMake(sliderWidth, 0.f, fieldWidth, itemHeight);
    
    self.middleSlider.frame = CGRectMake(0.f, itemHeight, sliderWidth, itemHeight);
    self.middleField.frame  = CGRectMake(sliderWidth, itemHeight, fieldWidth, itemHeight);
    
    self.bottomSlider.frame = CGRectMake(0.f, itemHeight * 2.f, sliderWidth, itemHeight);
    self.bottomField.frame  = CGRectMake(sliderWidth, itemHeight * 2.f, fieldWidth, itemHeight);
    
    self.alphaSlider.frame  = CGRectMake(0.f, itemHeight * 3.f, sliderWidth, itemHeight);
    self.bottomField.frame  = CGRectMake(sliderWidth, itemHeight * 3.f, fieldWidth, itemHeight);
    
}

- (void)setColorMode:(CMCColorPickerViewMode)colorMode
{
    _colorMode = colorMode;
    [self configureForColorMode];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self configureForColor];
}

- (void)configureForColorMode
{
    
    self.colorModeControl.selectedSegmentIndex = self.colorMode;
    
    if (self.colorMode == CMCColorPickerViewModeHSB)
    {
        UIImage *hueImage = [self hueImageForSize:self.topSlider.frame.size];
        self.topSlider.backgroundView = [[UIImageView alloc] initWithImage:hueImage];
        
    }
    else
    {
        
    }
    
    [self configureForColor];
}

- (void)colorModeControlChanged:(UISegmentedControl *)control
{
    self.colorMode = control.selectedSegmentIndex;
}

- (void)configureForColor
{
    CGFloat hue, saturation, brightness, alpha;
    [self.color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    self.topField.text = [@(hue) stringValue];
    self.middleField.text = [@(saturation) stringValue];
    self.bottomField.text = [@(brightness) stringValue];
    self.alphaField.text = [@(alpha) stringValue];
}

- (UIImage *)hueImageForSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContext(imageSize);
    
    for (NSInteger i = 0; i < imageSize.width; i++)
    {
        UIColor *color = [UIColor colorWithHue:i / imageSize.width saturation:1.f brightness:1.f alpha:1.f];
        [color setFill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(i, 0.f, 1.f, imageSize.height)] fill];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

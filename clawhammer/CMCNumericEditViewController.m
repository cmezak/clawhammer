//
//  CMCNumericEditViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCNumericEditViewController.h"
#import "CMCNumericTweakDescriptor.h"

@interface CMCNumericEditViewController ()
@property (nonatomic, strong) UISlider *slider;
@end

@implementation CMCNumericEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.numberField = [UITextField new];
    self.numberField.keyboardType = UIKeyboardTypeDecimalPad;
    self.numberField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.numberField.frame = CGRectMake(0.f, CGRectGetHeight(self.navigationController.navigationBar.frame) + 60.f, CGRectGetWidth(self.view.bounds), 80.f);
    self.numberField.text = [self.tweakDescriptor.tweakValue stringValue];
    self.numberField.textAlignment = NSTextAlignmentCenter;
    self.numberField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.numberField];
    
    self.slider = [UISlider new];
    self.slider.frame = CGRectMake(20.f, CGRectGetMaxY(self.numberField.frame), CGRectGetWidth(self.view.bounds) - 40.f, 40.f);
    [self.slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
    
    self.slider.hidden = !(self.tweakDescriptor.minimumValue && self.tweakDescriptor.maximumValue);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.numberField becomeFirstResponder];
}

- (void)setTweakDescriptor:(CMCNumericTweakDescriptor *)tweakDescriptor
{
    [super setTweakDescriptor:tweakDescriptor];
    self.numberField.text = [tweakDescriptor.tweakValue stringValue];
    self.slider.hidden = !(self.tweakDescriptor.minimumValue && self.tweakDescriptor.maximumValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sliderChanged:(UISlider *)slider
{
    double newValue = [self.tweakDescriptor.minimumValue doubleValue] + slider.value * ([self.tweakDescriptor.maximumValue doubleValue] - [self.tweakDescriptor.minimumValue doubleValue]);
    
    if ([self.tweakDescriptor.precision isEqualToString:CMCNumericTweakPrecisionDouble])
        self.numberField.text = [[NSNumber numberWithDouble:newValue] stringValue];
    
    else if ([self.tweakDescriptor.precision isEqualToString:CMCNumericTweakPrecisionFloat])
        self.numberField.text = [[NSNumber numberWithFloat:newValue] stringValue];
    
    else
        self.numberField.text = [[NSNumber numberWithInteger:newValue] stringValue];
    
    [self.numberField setSelectedTextRange:[self.numberField textRangeFromPosition:self.numberField.beginningOfDocument toPosition:self.numberField.endOfDocument]];
    
}

- (void)save:(id)sender
{
    if ([self.tweakDescriptor.precision isEqualToString:CMCNumericTweakPrecisionDouble])
        self.tweakDescriptor.tweakValue = @([self.numberField.text doubleValue]);
  
    
    else if ([self.tweakDescriptor.precision isEqualToString:CMCNumericTweakPrecisionFloat])
        self.tweakDescriptor.tweakValue = @([self.numberField.text floatValue]);

    else
        self.tweakDescriptor.tweakValue = @([self.numberField.text intValue]);

    [super save:sender];
}

@end

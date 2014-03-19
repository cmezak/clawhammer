//
//  CMCColorEditViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCColorEditViewController.h"

static const NSInteger rgbControlIndex = 0;
static const NSInteger hsbControlIndex = 1;
static const NSInteger swatchControlIndex = 2;

@interface CMCColorEditViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

// rgb
@property (nonatomic, strong) UIView *rgbContainerView;
@property (nonatomic, strong) UITextField *redField;
@property (nonatomic, strong) UITextField *blueField;
@property (nonatomic, strong) UITextField *greenField;
@property (nonatomic, strong) UITextField *rgbAlphaField;
@property (nonatomic, strong) UISlider *redSlider;
@property (nonatomic, strong) UISlider *greenSlider;
@property (nonatomic, strong) UISlider *blueSlider;
@property (nonatomic, strong) UISlider *rgbAlphaslider;

// hsb
@property (nonatomic, strong) UIView *hsbContainerView;
@property (nonatomic, strong) UITextField *hueField;
@property (nonatomic, strong) UITextField *saturationField;
@property (nonatomic, strong) UITextField *brightnessField;
@property (nonatomic, strong) UITextField *hsbAlphaField;
@property (nonatomic, strong) UISlider *hueSlider;
@property (nonatomic, strong) UISlider *saturationSlider;
@property (nonatomic, strong) UISlider *brightnessSlider;
@property (nonatomic, strong) UISlider *hsbAlphaslider;

// swatches
@property (nonatomic, strong) UICollectionView *swatchCollectionView;

@end

@implementation CMCColorEditViewController

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
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"rgb", @"hsb", @"swatches"]];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.frame = CGRectMake(0.f, CGRectGetHeight(self.navigationController.navigationBar.frame), CGRectGetWidth(self.view.bounds), 44.f);
    [self.view addSubview:self.segmentedControl];
    
}

- (void)segmentedControlChanged:(UISegmentedControl *)control
{
    if (control.selectedSegmentIndex == rgbControlIndex)
    {
        self.rgbContainerView.hidden = NO;
        self.swatchCollectionView.hidden = YES;
        self.hsbContainerView.hidden = YES;
    }
    else if (control.selectedSegmentIndex == hsbControlIndex)
    {
        self.rgbContainerView.hidden = YES;
        self.swatchCollectionView.hidden = YES;
        self.hsbContainerView.hidden = NO;
    }
    else if (control.selectedSegmentIndex == swatchControlIndex)
    {
        self.rgbContainerView.hidden = YES;
        self.swatchCollectionView.hidden = NO;
        self.hsbContainerView.hidden = YES;
    }
}

@end

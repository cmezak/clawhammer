//
//  DetailViewController.m
//  clawhammer-demo
//
//  Created by Charlie Mezak on 3/17/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "DetailViewController.h"
#import "NSObject+CMCTweaking.h"
#import "CMCTweakManager.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.detailDescriptionLabel registerforTweakWithName:@"labelFont" forKeyPath:@"font"];
    [self.detailDescriptionLabel registerforTweakWithName:@"labelText" forKeyPath:@"text"];
    [self.detailDescriptionLabel registerforTweakWithName:@"labelTextColor" forKeyPath:@"textColor"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleLabelTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)handleLabelTap:(UITapGestureRecognizer *)tapRecognizer
{
    NSTimeInterval animationDuration = [[CMCTweakManager sharedManager] timeIntervalForKey:@"labelAnimationDuration"];
    
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    fullRotation.duration = animationDuration;
    fullRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *bobbing = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bobbing.fromValue = @(self.detailDescriptionLabel.center.y);
    bobbing.toValue = @(self.detailDescriptionLabel.center.y + 100.f);
    bobbing.autoreverses = YES;
    bobbing.duration = animationDuration * 0.5;
    bobbing.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.detailDescriptionLabel.layer addAnimation:fullRotation forKey:nil];
    [self.detailDescriptionLabel.layer addAnimation:bobbing forKey:nil];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end

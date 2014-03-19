//
//  CMCEditViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCEditViewController.h"
#import "CMCStringTweakDescriptor.h"

@interface CMCEditViewController ()

@end

@implementation CMCEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
}

- (void)cancel:(id)sender
{
    [self.delegate editViewControllerDidCancel:self];
}

- (void)save:(id)sender
{
    [self.delegate editViewControllerDidSave:self];
}

@end

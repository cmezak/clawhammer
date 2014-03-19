//
//  CMCStringEditViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCStringEditViewController.h"
#import "CMCStringTweakDescriptor.h"

@interface CMCStringEditViewController ()

@end

@implementation CMCStringEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stringTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.stringTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self.view addSubview:self.stringTextView];
    
    _stringTextView.text = self.tweakDescriptor.tweakValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_stringTextView becomeFirstResponder];
}

- (void)setTweakDescriptor:(CMCTweakDescriptor *)tweakDescriptor
{
    [super setTweakDescriptor:tweakDescriptor];
    _stringTextView.text = [tweakDescriptor tweakValue];
}

- (void)save:(id)sender
{
    self.tweakDescriptor.tweakValue = self.stringTextView.text;
    [super save:sender];
}

@end

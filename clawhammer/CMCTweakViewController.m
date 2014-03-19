//
//  CMCTweakViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCTweakViewController.h"
#import "CMCTweakDescriptor.h"
#import "CMCNumericTweakDescriptor.h"
#import "CMCFontTweakDescriptor.h"
#import "CMCStringTweakDescriptor.h"
#import "CMCColorTweakDescriptor.h"

#import "CMCStringEditViewController.h"
#import "CMCFontEditViewController.h"
#import "CMCNumericEditViewController.h"
#import "CMCColorEditViewController.h"

@interface CMCTweakViewController () <UITableViewDataSource, UITableViewDelegate, CMCEditViewControllerDelegate>

@end

@implementation CMCTweakViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Tweakin'";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView reloadData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setTweakDescriptors:(NSArray *)tweakDescriptors
{
    _tweakDescriptors = tweakDescriptors;
    [self.tableView reloadData];
}

- (void)doneButtonTapped:(id)sender
{
    [self.delegate tweakViewControllerDidFinish:self];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweakDescriptors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMCTweakDescriptor *descriptor = _tweakDescriptors[indexPath.row];
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TweakCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TweakCell"];
    }
    
    cell.textLabel.text = descriptor.tweakName;
    cell.detailTextLabel.text = descriptor.tweakValueDescription;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMCTweakDescriptor *descriptor = self.tweakDescriptors[indexPath.row];
    Class editViewControllerClass;
    
    if ([descriptor isMemberOfClass:[CMCFontTweakDescriptor class]])
        editViewControllerClass = [CMCFontEditViewController class];
    
    else if ([descriptor isMemberOfClass:[CMCStringTweakDescriptor class]])
        editViewControllerClass = [CMCStringEditViewController class];
    
    else if ([descriptor isMemberOfClass:[CMCNumericTweakDescriptor class]])
        editViewControllerClass = [CMCNumericEditViewController class];
    
    else if ([descriptor isMemberOfClass:[CMCColorTweakDescriptor class]])
        editViewControllerClass = [CMCColorEditViewController class];
    
    CMCEditViewController *editViewController = [editViewControllerClass new];
    editViewController.tweakDescriptor = descriptor;
    editViewController.delegate = self;
    editViewController.title = descriptor.tweakName;
    [self.navigationController pushViewController:editViewController animated:YES];
}

#pragma mark CMCEditViewControllerDelegate

- (void)editViewControllerDidCancel:(CMCEditViewController *)editViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editViewControllerDidSave:(CMCEditViewController *)editViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

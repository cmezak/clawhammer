//
//  CMCFontEditViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCFontEditViewController.h"

#import "CMCFontTweakDescriptor.h"

static const CGFloat kPreviewHeight = 80.f;
static const CGFloat kSizeSliderHeight = 80.f;

@interface CMCFontEditViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *indexLetters;
@property (nonatomic, strong) NSDictionary *fontNamesByLetter;
@property (nonatomic, strong) UILabel *previewLabel;
@property (nonatomic, strong) UISlider *sizeSlider;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UIFont *tweakFont;
@end

@implementation CMCFontEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGRect tableViewRect, remainder;
    CGRectDivide(self.view.bounds,
                 &remainder,
                 &tableViewRect,
                 navigationBarHeight + kSizeSliderHeight + kPreviewHeight, CGRectMinYEdge);
    self.tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.previewLabel = [UILabel new];
    self.previewLabel.font = self.tweakDescriptor.tweakValue;
    self.previewLabel.text = @"Hello!";
    self.previewLabel.textAlignment = NSTextAlignmentCenter;
    ;    self.previewLabel.frame = CGRectMake(0.f, 64.f, CGRectGetWidth(self.view.bounds), kPreviewHeight);
    [self.view addSubview:self.previewLabel];
    
    self.sizeSlider = [UISlider new];
    CGFloat kSliderHeight = 30.f;
    self.sizeSlider.frame = CGRectMake(0.f, CGRectGetMinY(self.tableView.frame) - kSliderHeight, CGRectGetWidth(self.view.bounds), kSliderHeight);
    [self.view addSubview:self.sizeSlider];
    self.sizeSlider.hidden = !self.tweakDescriptor.allowsSizeTweaking;
    self.sizeSlider.value = ([self.tweakFont pointSize] - self.tweakDescriptor.minimumPointSize.floatValue) / (self.tweakDescriptor.maximumPointSize.floatValue - self.tweakDescriptor.minimumPointSize.floatValue);
    [self.sizeSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.sizeLabel = [UILabel new];
    self.sizeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    self.sizeLabel.frame = CGRectMake(0.f, CGRectGetMinY(self.sizeSlider.frame) - 15.f, CGRectGetWidth(self.view.bounds), 15.f);
    self.sizeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.sizeLabel];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
 
    NSMutableDictionary *fontNamesByLetter = [NSMutableDictionary new];
    NSMutableArray *indexLetters = [NSMutableArray new];
    for (NSString *familyName in [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)])
    {
        for (NSString *fontName in [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingSelector:@selector(compare:)])
        {

            NSString *firstLetter = [fontName substringToIndex:1];
            NSMutableArray *fontNames = fontNamesByLetter[firstLetter];
            if (fontNames == nil)
            {
                fontNames = [NSMutableArray new];
                fontNamesByLetter[firstLetter] = fontNames;
                [indexLetters addObject:firstLetter];
            }
            [fontNames addObject:fontName];
            
        }
    }
    
    self.indexLetters = [indexLetters copy];
    self.fontNamesByLetter = [fontNamesByLetter copy];
    
    [self.tableView reloadData];
    
}

- (void)setTweakDescriptor:(CMCFontTweakDescriptor *)tweakDescriptor
{
    [super setTweakDescriptor:tweakDescriptor];
    self.tweakFont = self.tweakDescriptor.tweakValue;
    self.sizeSlider.value = ([self.tweakFont pointSize] - self.tweakDescriptor.minimumPointSize.floatValue) / (self.tweakDescriptor.maximumPointSize.floatValue - self.tweakDescriptor.minimumPointSize.floatValue);
    [self.tableView reloadData];
}

- (void)sliderChanged:(UISlider *)slider
{
    CGFloat pointsize = self.tweakDescriptor.minimumPointSize.floatValue + (self.tweakDescriptor.maximumPointSize.floatValue - self.tweakDescriptor.minimumPointSize.floatValue) * slider.value;
    pointsize = floorf(pointsize);
    self.sizeLabel.text = [NSString stringWithFormat:@"%@pts", @(pointsize)];
    self.tweakFont = [UIFont fontWithName:self.tweakFont.fontName size:pointsize];
}

- (void)setTweakFont:(UIFont *)tweakFont
{
    _tweakFont = tweakFont;
    self.previewLabel.font = tweakFont;
}

- (void)save:(id)sender
{
    self.tweakDescriptor.tweakValue = self.tweakFont;
    [super save:sender];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexLetters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *letter = self.indexLetters[section];
    NSArray *names = self.fontNamesByLetter[letter];
    return [names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *letter = self.indexLetters[indexPath.section];
    NSArray *names = self.fontNamesByLetter[letter];
    NSString *fontName = names[indexPath.row];
    
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:18.f];
    cell.accessoryType = ([[self.tweakFont fontName] isEqualToString:fontName]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *letter = self.indexLetters[section];
    return letter;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexLetters;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *letter = self.indexLetters[indexPath.section];
    NSArray *names = self.fontNamesByLetter[letter];
    NSString *fontName = names[indexPath.row];
    
    CGFloat pointSize;
    if (self.tweakDescriptor.allowsSizeTweaking)
    {
        pointSize = self.tweakDescriptor.minimumPointSize.floatValue + self.sizeSlider.value * (self.tweakDescriptor.maximumPointSize.floatValue - self.tweakDescriptor.minimumPointSize.floatValue);
    }
    else
    {
        pointSize = self.tweakDescriptor.tweakValue.pointSize;
    }
    
    self.tweakFont = [UIFont fontWithName:fontName size:pointSize];
    [self.tableView reloadData];
}

@end

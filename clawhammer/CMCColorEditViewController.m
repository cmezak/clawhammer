//
//  CMCColorEditViewController.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/19/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCColorEditViewController.h"

#import "CMCColorTweakDescriptor.h"
#import "CMCTweakManager.h"

static const CGFloat kColorViewHeight = 50.f;

@interface CMCColorEditViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSArray *sliders;
@property (nonatomic, strong) NSArray *fields;

@property (nonatomic, strong) NSArray *otherDescriptors;

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UISegmentedControl *colorModeControl;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CMCColorEditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *colorDescriptors = [[[CMCTweakManager sharedManager] colorDescriptors] mutableCopy];
    [colorDescriptors removeObject:self.tweakDescriptor];
    self.otherDescriptors = [colorDescriptors copy];
    
    NSMutableArray *sliders = [NSMutableArray new];
    NSMutableArray *fields = [NSMutableArray new];
    
    CGFloat fieldWidth = 80.f;
    
    for (int i = 0; i < 4; i++)
    {
        UISlider *slider = [UISlider new];
        slider.frame = CGRectMake(20.f, 0.f, CGRectGetWidth(self.view.bounds) - 40.f - fieldWidth, kColorViewHeight);
        [sliders addObject:slider];
        slider.tag = i;
        [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
        UITextField *field = [UITextField new];
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.frame = CGRectMake(CGRectGetMaxX(slider.frame) + 10.f, 10.f, fieldWidth - 20.f, kColorViewHeight - 20.f);
        field.tag = i;
        field.keyboardType = UIKeyboardTypeDecimalPad;
        field.delegate = self;
        [fields addObject:field];
        
    }
    self.sliders = sliders;
    self.fields = fields;
    
    self.colorModeControl = [[UISegmentedControl alloc] initWithItems:@[@"RGB", @"HSB"]];
    self.colorModeControl.selectedSegmentIndex = 0;
    [self.colorModeControl addTarget:self action:@selector(colorModeControlChanged:) forControlEvents:UIControlEventValueChanged];
    self.colorModeControl.center = CGPointMake(CGRectGetMidX(self.view.bounds), kColorViewHeight * 0.5f);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SliderCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ColorCell"];
    [self.view addSubview:self.tableView];
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(self.view.bounds), kColorViewHeight)];
    [self.tableView setTableHeaderView:self.colorView];
    self.colorView.backgroundColor = self.color;
    
    self.colorMode = CMCColorModeRGB;
}

- (void)setTweakDescriptor:(CMCColorTweakDescriptor *)tweakDescriptor
{
    self.color = tweakDescriptor.tweakValue;
    [super setTweakDescriptor:tweakDescriptor];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    self.colorView.backgroundColor = color;
    
    [self setSliderValuesForColor:NO];
}

- (void)setColorMode:(CMCColorMode)colorMode
{
    [self setColorMode:colorMode animated:NO];
}

- (void)setColorMode:(CMCColorMode)colorMode animated:(BOOL)animated
{
    _colorMode = colorMode;
    [self setSliderValuesForColor:animated];

}

- (void)setSliderValuesForColor:(BOOL)animated
{
    if (self.colorMode == CMCColorModeRGB)
    {
        CGFloat red, green, blue, alpha;
        [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
        [(UISlider *)self.sliders[0] setValue:red animated:animated];
        [(UISlider *)self.sliders[1] setValue:green animated:animated];
        [(UISlider *)self.sliders[2] setValue:blue animated:animated];
        [(UISlider *)self.sliders[3] setValue:alpha animated:animated];
        
        [self.sliders[0] setMinimumTrackTintColor:[UIColor redColor]];
        [self.sliders[1] setMinimumTrackTintColor:[UIColor greenColor]];
        [self.sliders[2] setMinimumTrackTintColor:[UIColor blueColor]];
        [self.sliders[3] setMinimumTrackTintColor:[UIColor lightGrayColor]];
        
        [(UITextField *)self.fields[0] setText:[NSString stringWithFormat:@"%d", (int)(255.f * red)]];
        [(UITextField *)self.fields[1] setText:[NSString stringWithFormat:@"%d",(int)(255.f * green)]];
        [(UITextField *)self.fields[2] setText:[NSString stringWithFormat:@"%d", (int)(255.f * blue)]];
        [(UITextField *)self.fields[3] setText:[NSString stringWithFormat:@"%d", (int)(255.f * alpha)]];
    }
    else
    {
        CGFloat hue, saturation, brightness, alpha;
        [self.color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        [(UISlider *)self.sliders[0] setValue:hue animated:animated];
        [(UISlider *)self.sliders[1] setValue:saturation animated:animated];
        [(UISlider *)self.sliders[2] setValue:brightness animated:animated];
        [(UISlider *)self.sliders[3] setValue:alpha animated:animated];
        
        [(UITextField *)self.fields[0] setText:[NSString stringWithFormat:@"%d", (int)(255.f * hue)]];
        [(UITextField *)self.fields[1] setText:[NSString stringWithFormat:@"%d",(int)(255.f * saturation)]];
        [(UITextField *)self.fields[2] setText:[NSString stringWithFormat:@"%d", (int)(255.f * brightness)]];
        [(UITextField *)self.fields[3] setText:[NSString stringWithFormat:@"%d", (int)(255.f * alpha)]];
    }
}

- (void)colorModeControlChanged:(UISegmentedControl *)control
{
    if (control.selectedSegmentIndex == 0) [self setColorMode:CMCColorModeRGB animated:YES];
    else if (control.selectedSegmentIndex == 1) [self setColorMode:CMCColorModeHSB animated:YES];
}

- (void)sliderChanged:(UISlider *)slider
{
    
    if (self.colorMode == CMCColorModeRGB)
    {
        CGFloat red, green, blue, alpha;
        [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
        
        switch (slider.tag) {
            case 0:
                red = slider.value;
                break;
            case 1:
                green = slider.value;
                break;
            case 2:
                blue = slider.value;
                break;
            case 3:
                alpha = slider.value;
                break;
            default:
                break;
        }
        
        self.color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }

    else
    {
        CGFloat hue, saturation, brightness, alpha;
        [self.color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        switch (slider.tag) {
            case 0:
                hue = slider.value;
                break;
            case 1:
                saturation = slider.value;
                break;
            case 2:
                brightness = slider.value;
                break;
            case 3:
                alpha = slider.value;
                break;
            default:
                break;
        }
        
        self.color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
}

- (void)save:(id)sender
{
    self.tweakDescriptor.tweakValue = self.color;
    [super save:sender];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        // mode + rgb/hsb + a
        return 5;
    }
    else
    {
        return self.otherDescriptors.count;
    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    else return @"Other Tweaks";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kColorViewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SliderCell"];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if (indexPath.row == 0)
            [cell.contentView addSubview:self.colorModeControl];
        else
        {
            [cell.contentView addSubview:self.sliders[indexPath.row - 1]];
            [cell.contentView addSubview:self.fields[indexPath.row - 1]];

        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCell"];
        CMCColorTweakDescriptor *descriptor = self.otherDescriptors[indexPath.row];
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 30.f, 30.f)];
        colorView.backgroundColor = descriptor.tweakValue;
        cell.accessoryView = colorView;
        cell.textLabel.text = descriptor.tweakName;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        CMCColorTweakDescriptor *descriptor = self.otherDescriptors[indexPath.row];
        self.color = descriptor.tweakValue;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setSelectedTextRange:[textField textRangeFromPosition:[textField beginningOfDocument]
                                                          toPosition:[textField endOfDocument]]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.floatValue > 255) textField.text = @"255";
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGFloat value = [textField.text integerValue];
    UISlider *slider = self.sliders[textField.tag];
    [slider setValue:value / 255.f];
    [self sliderChanged:slider];
    
}

@end

//
//  CMCTweakManager.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "CMCTweakManager.h"
#import "CMCTweakViewController.h"
#import "CMCTweakDescriptor.h"
#import "CMCNumericTweakDescriptor.h"
#import "CMCFontTweakDescriptor.h"
#import "CMCStringTweakDescriptor.h"
#import "CMCColorTweakDescriptor.h"

@interface CMCTweakManager () <CMCTweakViewControllerDelegate>
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSMutableDictionary *valuesByKey;
@end

static NSString *SpecName;
static NSDictionary *TweakDescriptors;
static NSArray *AllDescriiptors;

@implementation CMCTweakManager

+ (CMCTweakManager *)sharedManager
{
    NSAssert(SpecName, @"You must first set the spec name by calling +setupWithSpecNamed: before you can talk to the shared tweak namanger");
    
    static CMCTweakManager *SharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedManager = [CMCTweakManager new];
    });
    
    return SharedManager;
}

+ (void)initialize
{
    [self setupWithSpecName:@"clawhammer"];
}

+ (void)setupWithSpecName:(NSString *)specName
{
    SpecName = specName;
    TweakDescriptors = [NSDictionary new];
    
    NSURL *specURL = [[NSBundle mainBundle] URLForResource:SpecName withExtension:@"json"];
    NSDictionary *specDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:specURL] options:0 error:nil];
    NSLog(@"loaded spec dict: %@", specDict);
    
    // populate the groups array
    NSMutableDictionary *descriptors = [NSMutableDictionary dictionary];
    NSMutableArray *allDescriptors = [NSMutableArray new];
    [specDict enumerateKeysAndObjectsUsingBlock:^(NSString *tweakName, NSDictionary *descriptorConfig, BOOL *stop) {
        
        NSString *tweakType = descriptorConfig[@"type"];
        Class descriptorClass;
        
        if ([tweakType isEqualToString:@"number"])
            descriptorClass = [CMCNumericTweakDescriptor class];
        
        else if ([tweakType isEqualToString:@"font"])
            descriptorClass = [CMCFontTweakDescriptor class];
        
        else if ([tweakType isEqualToString:@"string"])
            descriptorClass = [CMCStringTweakDescriptor class];
        
        else if ([tweakType isEqualToString:@"color"])
            descriptorClass = [CMCColorTweakDescriptor class];
            
        else
            descriptorClass = [CMCTweakDescriptor class];
        
        CMCTweakDescriptor *descriptor = [descriptorClass new];
        descriptor.tweakName = tweakName;
        [descriptor setValuesForKeysWithDictionary:descriptorConfig];
        
        descriptors[tweakName] = descriptor;
        [allDescriptors addObject:descriptor];
        
    }];
    
    
    AllDescriiptors = [allDescriptors copy];
    TweakDescriptors = [descriptors copy];
}

- (void)prersentTweakInterfaceWithPresentingViewController:(UIViewController *)presentingViewController;
{
    CMCTweakViewController *tweakViewController = [CMCTweakViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tweakViewController];
    __block NSMutableArray *descriptorArray = [NSMutableArray array];
    [TweakDescriptors enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [descriptorArray addObject:obj];
    }];
    
    tweakViewController.tweakDescriptors = descriptorArray;
    tweakViewController.delegate = self;
    [presentingViewController presentViewController:navigationController animated:YES completion:nil];
}

- (void)sendChangeNotificationForKey:(id)key value:(id)value
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CMCClawhammerTweakDidChangeValueNotification
                                                        object:key
                                                      userInfo:@{CMCClawhammerTweakValueKey: value}];
}

- (NSArray *)colorDescriptors
{
    return [AllDescriiptors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject isMemberOfClass:[CMCColorTweakDescriptor class]];
    }]];
}

#pragma mark Getting Values

- (CMCTweakDescriptor *)tweakForKey:(id)key
{
    return TweakDescriptors[key];
}

- (id)valueForKey:(NSString *)key
{
    return [[self tweakForKey:key] tweakValue];
}

- (CGFloat)floatForKey:(NSString *)key
{
    return [[[self tweakForKey:key] tweakValue] floatValue];
}
- (NSTimeInterval)timeIntervalForKey:(NSString *)key
{
    return [[[self tweakForKey:key] tweakValue] doubleValue];
}

- (UIColor *)colorForKey:(NSString *)key
{
    return [UIColor redColor];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [UIImage imageNamed:[[self tweakForKey:key] tweakValue]];
}

- (NSString *)stringForKey:(NSString *)key
{
    return [TweakDescriptors[key] tweakValue];
}

- (UIFont *)fontForKey:(NSString *)key
{
    CMCFontTweakDescriptor *fontDescriptor = (CMCFontTweakDescriptor *)[self tweakForKey:key];
    return [fontDescriptor tweakValue];
}

#pragma mark CMCTweakViewControllerDelegate

- (void)tweakViewControllerDidFinish:(CMCTweakViewController *)tweakViewController
{
    [tweakViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tweakViewControllerDidCancel:(CMCTweakViewController *)tweakViewController
{
    [tweakViewController dismissViewControllerAnimated:YES completion:nil];

}

@end

//
//  CMCTweakManager.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "CMCTweakDescriptor.h"

@interface CMCTweakManager : NSObject

@property (nonatomic, readonly) NSString *specName;

+ (void)setupWithSpecName:(NSString *)specName;
+ (CMCTweakManager *)sharedManager;

- (id)valueForKey:(NSString *)key;
- (CGFloat)floatForKey:(NSString *)key;
- (NSTimeInterval)timeIntervalForKey:(NSString *)key;
- (UIFont *)fontForKey:(NSString *)key;
- (UIColor *)colorForKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

- (NSArray *)colorDescriptors;

/**
 *  Shows the UI allowing the use to change tweak values
 */
- (void)prersentTweakInterfaceWithPresentingViewController:(UIViewController *)presentingViewController;

@end

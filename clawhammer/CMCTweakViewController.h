//
//  CMCTweakViewController.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMCTweakViewController;

@protocol CMCTweakViewControllerDelegate <NSObject>

- (void)tweakViewControllerDidCancel:(CMCTweakViewController *)tweakViewController;
- (void)tweakViewControllerDidFinish:(CMCTweakViewController *)tweakViewController;

@end

@interface CMCTweakViewController : UIViewController

@property (nonatomic, weak) id <CMCTweakViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *tweakDescriptors;
@property (nonatomic, strong) UITableView *tableView;

@end

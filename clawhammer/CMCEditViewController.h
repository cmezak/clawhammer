//
//  CMCEditViewController.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMCTweakDescriptor;
@class CMCEditViewController;

@protocol CMCEditViewControllerDelegate <NSObject>

- (void)editViewControllerDidCancel:(CMCEditViewController *)editViewController;
- (void)editViewControllerDidSave:(CMCEditViewController *)editViewController;

@end

@interface CMCEditViewController : UIViewController

@property (nonatomic, strong) id tweakDescriptor;
@property (nonatomic, weak) id <CMCEditViewControllerDelegate> delegate;
- (void)save:(id)sender;
- (void)cancel:(id)sender;

@end

//
//  NSObject+CMCTweakListener.m
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import "NSObject+CMCTweaking.h"
#import "CMCTweakManager.h"
#import <objc/runtime.h>

@implementation NSObject (CMCTweaking)



- (void)registerForTweakWithName:(NSString *)tweakName responseBlock:(void(^)(id value))responseBlock
{
    
    // construct the block that we will execute when a tweak changes. check to see that the tweak is the one we're watching, and, if so, execute the response block
    void (^notificationBlock)(NSNotification *) = ^(NSNotification *note){
        
        if ([note.userInfo[CMCClawhammerTweakNameKey] isEqualToString:tweakName])
        {
            responseBlock(note.userInfo[CMCClawhammerTweakValueKey]);
        }
        
    };
    
    // register for tweak change notifications
    id notificationListener = [[NSNotificationCenter defaultCenter] addObserverForName:CMCClawhammerTweakDidChangeValueNotification
                                                                                object:nil
                                                                                 queue:[NSOperationQueue mainQueue]
                                                                            usingBlock:notificationBlock];
    
    // execute the response block now with whatever the current tweak value is
    responseBlock([[CMCTweakManager sharedManager] valueForKey:tweakName]);
    
    // store the notification listener
#pragma clang diagnostic push
    // using a selector as an associated object key. don't care that it's not recognized
#pragma clang diagnostic ignored "-Wundeclared-selector"
    objc_setAssociatedObject(self, @selector(tweakName), notificationListener, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#pragma clang diagnostic pop

}

- (void)registerforTweakWithName:(NSString *)tweakName forKeyPath:(NSString *)keyPath
{
    [self registerForTweakWithName:tweakName responseBlock:^(id value) {
        [self setValue:value forKeyPath:keyPath];
    }];
}



@end

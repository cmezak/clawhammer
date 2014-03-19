//
//  NSObject+CMCTweakListener.h
//  clawhammer
//
//  Created by Charlie Mezak on 3/18/14.
//  Copyright (c) 2014 Charlie Mezak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CMCTweaking)

/**
 *  Registers the receiver to respond to changes in the tweak with the given name. When that tweak value is changed, the response block is executed.
 *
 *  @param tweakName     the name of the tweak that the receiver should respond to
 *  @param responseBlock a block that receives the tweak value. Can be used to update the receiver in some way.
 */
- (void)registerForTweakWithName:(NSString *)tweakName responseBlock:(void(^)(id value))responseBlock;

/**
 *  Registers the receiver to changes in the tweak with the given name. When the tweak value is changed, it's new value is sent with a setValue:forKeyPath: message to the receiver using the given key path.
 *
 *  @param tweakName the name of the tweak that the receiver should respond to
 *  @param keyPath   the key path that should be set to the value of the tweak
 */
- (void)registerforTweakWithName:(NSString *)tweakName forKeyPath:(NSString *)keyPath;

@end

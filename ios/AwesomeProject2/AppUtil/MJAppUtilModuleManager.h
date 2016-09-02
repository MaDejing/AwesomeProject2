//
//  MJAppUtilModuleManager.h
//  MiojiChat
//
//  Created by DejingMa on 16/7/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface MJAppUtilModuleManager : NSObject <RCTBridgeModule>

+ (NSURL *)bundleUrl;

@end

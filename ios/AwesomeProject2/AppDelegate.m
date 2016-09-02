/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *jsCodeLocation;
    
#if DEBUG
    jsCodeLocation = [NSURL URLWithString:@"http://10.2.0.194:8081/index.ios.bundle?platform=ios&dev=true"];
#else
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [[paths firstObject] stringByAppendingPathComponent:@"chat/main03.jsbundle"];
//    NSError *error;
//    NSString *fromPath = [[NSBundle mainBundle] pathForResource:@"main03" ofType:@"jsbundle"];
//    
//    if (fromPath) {
//        NSLog(@">>>>>>>>>>>>>>%@", fromPath);
//        [[NSFileManager defaultManager] copyItemAtPath: fromPath toPath: docDir error: &error];
//        if (error) {
//            NSLog(@">>>>>>>>>>>>fail\n%@", error);
//        } else {
//            NSLog(@">>>>>>>>>>>>success");
//        }
//    }
    
//    jsCodeLocation = [MJAppUtilModuleManager bundleUrl];
//    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif

//    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"AwesomeProject2"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

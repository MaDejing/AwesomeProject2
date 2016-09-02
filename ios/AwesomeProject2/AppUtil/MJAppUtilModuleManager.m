//
//  MJAppUtilModuleManager.m
//  MiojiChat
//
//  Created by DejingMa on 16/7/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MJAppUtilModuleManager.h"
#import "RCTConvert.h"

@implementation MJAppUtilModuleManager

static NSString *plistFileName = @"MJAppUtilDEST.plist";
static NSString *AppUtilKey = @"AppUtilDEST";

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(AppUtilModule)

+ (NSURL *)bundleUrl {
    NSURL *bundleURL;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths firstObject];

    NSString *plistFilePath = [docDir stringByAppendingPathComponent: plistFileName];
    BOOL plistFileExist = [MJAppUtilModuleManager fileExistWithPath: plistFilePath];
    
    if (plistFileExist) {
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile: plistFilePath];
        NSString *dest = dic[AppUtilKey];
        
        if (dest) {
            NSLog(@"==========dest in plist==========\n%@\n=========================\n", dest);
            
            NSArray *arr = [dest componentsSeparatedByString:@"/"];
            // bundles 存放目录
            NSString *bundlesPath = [MJAppUtilModuleManager createBundlesDirectory: arr[arr.count - 2]];
            
            NSString *jsFileName = [arr lastObject];
            NSString *jsFilePath = [bundlesPath stringByAppendingPathComponent: jsFileName];
            NSLog(@"============bundle url==========\n%@\n=========================\n", jsFilePath);
            BOOL jsFileExist = [MJAppUtilModuleManager fileExistWithPath:jsFilePath];
            
            if (jsFileExist) {
                NSLog(@"==========bundle file exists!!!==========\n");
                bundleURL = [NSURL fileURLWithPath: jsFilePath];
                return bundleURL;
            }
        }
    }
    return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
}

+ (BOOL)fileExistWithPath: (NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (NSString *)createBundlesDirectory: (NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths firstObject];
    NSString *bundlesPath = [docDir stringByAppendingPathComponent: name];
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:bundlesPath]) {
        NSLog(@"=============创建目录==============\n");
        [[NSFileManager defaultManager] createDirectoryAtPath:bundlesPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    return bundlesPath;
}

RCT_EXPORT_METHOD(setJSBundleFile: (NSString *)DEST) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths firstObject];
    NSString *filePath = [docDir stringByAppendingPathComponent: plistFileName];
    
    NSDictionary *dic = @{ AppUtilKey: DEST };
    [dic writeToFile:filePath atomically:YES];
}

RCT_EXPORT_METHOD(copyJSBundleFile: (NSString *)DEST) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths firstObject];
    NSString *bundlesPath = [docDir stringByAppendingPathComponent: @"chat"];
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:bundlesPath]) {
        NSLog(@"=============创建目录==============\n");
        [[NSFileManager defaultManager] createDirectoryAtPath:bundlesPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    NSString *bundle = [DEST lastPathComponent];
    NSArray *arr = [bundle componentsSeparatedByString:@"."];
    NSString *fromPath = [[NSBundle mainBundle] pathForResource:arr[0] ofType:arr[1]];
    NSString *toPath = [bundlesPath stringByAppendingPathComponent: bundle];

    if (fromPath) {
        NSLog(@">>>>>>>>>>>>%@\n", fromPath);
        [[NSFileManager defaultManager] copyItemAtPath: fromPath toPath: toPath error: &error];
        if (error) {
            NSLog(@">>>>>>>>>>>>fail\n%@\n", error);
        } else {
            NSLog(@">>>>>>>>>>>>success\n");
        }
    }
    
    NSString *picPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Bundles/assets"];
    NSString *picToPath = [[docDir stringByAppendingPathComponent: @"chat"] stringByAppendingPathComponent:@"assets"];
    if (picPath) {
        NSLog(@">>>>>>>>>>>>%@\n", picPath);
        [[NSFileManager defaultManager] copyItemAtPath: picPath toPath: picToPath error: &error];
        if (error) {
            NSLog(@">>>>>>>>>>>>fail\n%@\n", error);
        } else {
            NSLog(@">>>>>>>>>>>>success\n");
        }
    }
}

- (NSDictionary *)constantsToExport {
	return @{ @"version": [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] };
}

@end

//
//  RCTMapManager.m
//  AwesomeProject2
//
//  Created by DejingMa on 16/8/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MyNewViewManager.h"
#import "MyNewView.h"
#import "RCTConvert.h"

//@implementation RCTConvert ()
//
//@end

@implementation MyNewViewManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

//RCT_CUSTOM_VIEW_PROPERTY(isTrue, BOOL, MyNewView) {
//    BOOL is = [RCTConvert BOOL:json];
//    [view setIsTrue:is];
////    [view showLabel];
//}

- (UIView *)view {
    MyNewView *newView = [[MyNewView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];

    return newView;
}

RCT_EXPORT_METHOD(printLog:(id)json :(RCTResponseSenderBlock)callback) {
    NSArray *arr = [RCTConvert NSArray:json[@"employees"]];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = [RCTConvert NSDictionary:arr[i]];
        NSString *first = [RCTConvert NSString:dic[@"firstName"]];
        NSString *last = [RCTConvert NSString:dic[@"lastName"]];
        NSString *name = [first stringByAppendingString:last];
        NSLog(@">>>>>>>name: %@\n", name);
    }
}

@end

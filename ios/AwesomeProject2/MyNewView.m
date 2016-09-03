//
//  MyNewView.m
//  AwesomeProject2
//
//  Created by ; on 16/8/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MyNewView.h"
#import "RCTConvert.h"

@interface MyNewView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *editingTextField;
@property (nonatomic, assign) CGFloat scrollViewOffsetY;
@property (nonatomic, assign) CGFloat offsetDelta;
//@property (nonatomic, assign) BOOL isScrolled;

@end

@implementation MyNewView

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher {
    self = [super initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher];
    if (self) {        
        //键盘出现时，点击空白处键盘消失
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
        [self addGestureRecognizer:tap];
        tap.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)getIsEditingView:(UIView *)rootView {
    for (UIView *subView in rootView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            if (((UITextField *)subView).isEditing) {
                self.editingTextField = subView;
                return;
            }
        }
        [self getIsEditingView:subView];
    }
}

- (CGFloat)getSuperViewY:(UIView *)view {
    UIView *superView = view.superview;
    CGFloat maxY = 0;
    
    do {
        maxY += superView.frame.origin.y;
        superView = superView.superview;
    } while (![superView isKindOfClass:[UIScrollView class]]);
    
    maxY += self.frame.origin.y;
    
    return maxY;
}

- (void)keyboardWillShow:(NSNotification *)noti {
    // 拿到正在编辑中的textfield
    [self getIsEditingView:self];
    
    CGFloat maxOffsetY = self.scrollView.contentSize.height - self.frame.size.height;
    self.scrollViewOffsetY = MIN(self.scrollView.contentOffset.y, maxOffsetY);
    
    CGFloat maxY = CGRectGetHeight(self.editingTextField.superview.frame) + [self getSuperViewY:self.editingTextField] - self.scrollViewOffsetY;
    // 键盘的Y值
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = value.CGRectValue;
    // 动画
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGSize contentSize = self.scrollView.contentSize;
    
    [UIView animateWithDuration:duration animations:^{
//        self.isScrolled = NO;
        self.offsetDelta = 0;
        if (maxY > keyboardFrame.origin.y) {
//            self.isScrolled = YES;
            CGFloat offSet = maxY - keyboardFrame.origin.y;
            self.offsetDelta = offSet + 10;

//            [self.scrollView setContentSize:CGSizeMake(contentSize.width, contentSize.height + self.offsetDelta)];
            [self.scrollView setContentOffset:CGPointMake(0, self.scrollViewOffsetY + self.offsetDelta) animated:YES];
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGSize contentSize = self.scrollView.contentSize;

    [UIView animateWithDuration:duration animations:^{
        //让scrollView还原
//        CGFloat heightDelta = 0;
//        if (self.isScrolled) {
//            NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//            CGRect keyboardFrame = value.CGRectValue;
//            heightDelta = keyboardFrame.size.height;
//        }
//        [self.scrollView setContentSize:CGSizeMake(contentSize.width, contentSize.height - self.offsetDelta)];
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollViewOffsetY) animated:YES];
    }];
}

//- (void)showLabel {
//    UILabel *label = [[UILabel alloc]init];
//    label.text = self.isTrue ? @"yes" : @"no";
//    label.textColor = [UIColor whiteColor];
//    label.frame = CGRectMake(0, 0, 50, 30);
//    [self addSubview:label];
//}

- (void)dismissKeyboard {
    [self endEditing:YES];
}

@end

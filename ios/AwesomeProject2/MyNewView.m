//
//  MyNewView.m
//  AwesomeProject2
//
//  Created by ; on 16/8/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MyNewView.h"

@interface MyNewView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *editingTextField;
@property (nonatomic, assign) CGFloat scrollViewHeight;

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

- (void)keyboardWillShow:(NSNotification *)noti {
    // 拿到正在编辑中的textfield
    [self getIsEditingView:self];
    
    CGFloat maxY = CGRectGetMaxY(self.editingTextField.superview.superview.frame) + self.frame.origin.y;
    // 键盘的Y值
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = value.CGRectValue;
    // 动画
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGSize contentSize = self.scrollView.contentSize;
    
    [UIView animateWithDuration:duration animations:^{
        if (maxY > keyboardFrame.origin.y) {
            CGFloat offSet = maxY - keyboardFrame.origin.y;
            [self.scrollView setContentSize:CGSizeMake(contentSize.width, contentSize.height + keyboardFrame.size.height)];
            [self.scrollView setContentOffset:CGPointMake(0, offSet+10) animated:YES];
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = value.CGRectValue;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGSize contentSize = self.scrollView.contentSize;

    [UIView animateWithDuration:duration animations:^{
        //让scrollView还原
        [self.scrollView setContentSize:CGSizeMake(contentSize.width, contentSize.height - keyboardFrame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
}

- (void)showLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = self.isTrue ? @"yes" : @"no";
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(0, 0, 50, 30);
    [self addSubview:label];
}

- (void)dismissKeyboard {
    [self endEditing:YES];
}

@end

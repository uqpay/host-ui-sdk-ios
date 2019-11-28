//
//  UQUIKSMSFormField.m
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/7/19.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKSMSFormField.h"
#import "UQUIKLocalizedString.h"
#import "UQUIKAppearance.h"
#import "UQUIKViewUtil.h"

#define DURATION_TIME 60

@interface UQUIKSMSFormField()
@property (nonatomic,strong) UIButton *sendSMSBtn;
@property (nonatomic,strong) UIView *sendView;
@property (nonatomic, assign) NSInteger durationTime;
@property (nonatomic,weak) NSTimer* countDownTimer;
@end
@implementation UQUIKSMSFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = UQUIKLocalizedString(SMS_CODE_LABEL);
        self.formLabel.text = [NSString stringWithFormat: @"%@:",UQUIKLocalizedString(SMS_CODE_LABEL)];
        self.textField.textAlignment = [UQUIKViewUtil naturalTextAlignment];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
        UIView *sepLine = [[UIView alloc]init];
        sepLine.translatesAutoresizingMaskIntoConstraints = NO;
        sepLine.backgroundColor = [UQUIKAppearance sharedInstance].sepLineColor;
        
        self.sendView = [[UIView alloc]init];
        self.sendView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.sendView addSubview:sepLine];
        
        [self.sendView addSubview:self.sendSMSBtn];
        self.sendSMSBtn.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSMutableDictionary *dic = [@{ @"SendView":self.sendView, @"SepLine": sepLine, @"SendSMSBtn": self.sendSMSBtn} mutableCopy];
        
        NSDictionary* metrics = @{@"PADDING":@15};
        
        NSMutableArray *layoutConstraints = [NSMutableArray array];
        [layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[SepLine]|" options:0 metrics:metrics views:dic]];
        [layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[SendSMSBtn]|" options:0 metrics:metrics views:dic]];
        [layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[SepLine(1)]-[SendSMSBtn(120)]|" options:0 metrics:metrics views:dic]];
        
        [self.sendView addConstraints:[layoutConstraints copy]];
        self.accessoryView = self.sendView;
    }
    return self;
}


- (UIButton *)sendSMSBtn {
    if (_sendSMSBtn == nil) {
        _sendSMSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendSMSBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_sendSMSBtn setTitle:UQUIKLocalizedString(UQ_SEND_CODE) forState:UIControlStateNormal];
        [_sendSMSBtn setTitleColor:[UQUIKAppearance sharedInstance].defaultColor forState:UIControlStateNormal];
        [_sendSMSBtn setTitleColor:[UQUIKAppearance sharedInstance].smsDisabledColor forState:UIControlStateDisabled];
        [_sendSMSBtn sizeToFit];
        [_sendSMSBtn layoutIfNeeded];
        [_sendSMSBtn addTarget:self action:@selector(sendSMSCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendSMSBtn;
}

- (void)sendSMSCode:(UIButton *)btn {
    if (self.smsDelegate && [self.smsDelegate respondsToSelector:@selector(sendSMS:success:)]) {
        [self.smsDelegate sendSMS:btn success:^(BOOL success) {
            if (success) {
                self.durationTime = DURATION_TIME;
                btn.enabled = FALSE;
                [[NSRunLoop currentRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
            }
        }];
        
    }
}

- (void)countDown:(NSTimer*)timer {
    self.durationTime--;
   
    [self.sendSMSBtn setTitle: [NSString localizedStringWithFormat: UQUIKLocalizedString(UQ_SEND_ANAGIN), self.durationTime] forState:UIControlStateDisabled];
    if (self.durationTime == 0) {
        [self.countDownTimer invalidate];
        self.durationTime = DURATION_TIME;
        self.sendSMSBtn.enabled = TRUE;
    }
}

- (NSTimer *)countDownTimer {
    if (_countDownTimer == nil) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
    return _countDownTimer;
}

- (void)dealloc {
    if (self.countDownTimer) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
    
}

@end

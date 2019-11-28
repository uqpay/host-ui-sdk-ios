//
//  UQUIKSelectCardView.m
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/7/5.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKSelectCardView.h"

#define UQ_SELECT_CARD_CORNER_RADIUS 5
#define UQ_SELECT_CARD_BORDER_WIDTH 1

@interface UQUIKSelectCardView()

@end


@implementation UQUIKSelectCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI {
    [self addSubview:self.textView];
}


- (UILabel *)textView {
    if (_textView == nil) {
        _textView = [[UILabel alloc]init];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:32];
        _textView.textColor = [UQUIKAppearance sharedInstance].secondaryTextColor;
    }
    return _textView;
}

- (void)select {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = UQ_SELECT_CARD_CORNER_RADIUS;
    self.layer.borderWidth = UQ_SELECT_CARD_BORDER_WIDTH;
    self.layer.borderColor = [UQUIKAppearance sharedInstance].lineColor.CGColor;
    
    [self.textView sizeToFit];
    self.textView.center = CGPointMake(CGRectGetWidth(self.bounds) /2, CGRectGetHeight(self.bounds)/2);
}

- (void)addTarget:(id)target actoin:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end

//
//  UQCardItemView.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/15.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQCardItemView.h"
#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

@interface UQCardItemView()

@property (nonatomic) NSString* title;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *cardLabel;
@property (nonatomic, strong) UIImageView *cardImg;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;

@end
@implementation UQCardItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
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

- (UILabel *)cardLabel {
    if (_cardLabel == nil) {
        _cardLabel = [[UILabel alloc]init];
        _cardLabel.font = [UIFont systemFontOfSize:22.f];
        _cardLabel.textColor = [UIColor colorWithRed:133./255 green:133./255 blue:133./255 alpha:1];
    }
    return _cardLabel;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (UIImageView *)cardImg {
    if (_cardImg == nil) {
        _cardImg = [[UIImageView alloc]init];
    }
    return _cardImg;
}

- (void)initUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.cardImg];
    [self.bgView addSubview:self.cardLabel];
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.bgView.frame = self.bounds;
//
//    self.cardImg.center = CGPointMake(CGRectGetWidth(self.bounds) /2 , CGRectGetHeight(self.bounds)/2);
//
//    [self.cardLabel sizeToFit];
//    self.cardLabel.center = CGPointMake(CGRectGetWidth(self.bounds) - 16 - CGRectGetWidth(self.cardLabel.bounds) / 2, CGRectGetHeight(self.bounds)/2);
//}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = self.bounds;

    self.cardImg.center = CGPointMake(self.cardImg.bounds.size.width /2, CGRectGetHeight(self.bgView.bounds)/2);
    [self.cardLabel sizeToFit];
    self.cardLabel.frame = CGRectMake(CGRectGetMaxX(self.cardImg.frame) + 15, 0, CGRectGetWidth(self.cardLabel.bounds), CGRectGetHeight(self.cardLabel.bounds));
    self.cardLabel.center = CGPointMake(self.cardLabel.center.x, CGRectGetHeight(self.bgView.bounds) /2);

    self.bgView.frame = CGRectMake(CGRectGetMidX(self.bgView.frame), CGRectGetMaxY(self.bgView.frame), CGRectGetMaxX(self.cardLabel.frame), self.bounds.size.height);
    self.bgView.center = CGPointMake(self.center.x, self.bounds.size.height/2);
}

- (void)setCardId:(NSString *)cardId {
    self.cardLabel.text = [NSString stringWithFormat:@"**** **** **** %@",cardId];
    [self.cardLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
    if (self.tapGestureRecognizer == nil) {
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self.target action:action];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
}

- (void)setCardImageName:(NSString *)imageName {
    UIImage *image = [[UQImageUtils shareInstance].icons objectForKey:imageName];
    if (image != nil) {
        [self.cardImg setImage:image];
        [self.cardImg sizeToFit];
    }
}

@end

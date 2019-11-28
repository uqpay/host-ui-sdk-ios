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
@property (nonatomic, strong) UILabel * titleLabel;
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

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:22.f];
        _titleLabel.textColor = [UIColor colorWithRed:153./255. green:153./255. blue:144./255. alpha:1];
        _titleLabel.text = UQUIKLocalizedString(CARD_NUMBER_PLACEHOLDER);
        [self.titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)cardLabel {
    if (_cardLabel == nil) {
        _cardLabel = [[UILabel alloc]init];
        _cardLabel.font = [UIFont systemFontOfSize:22.f];
        _cardLabel.textColor = [UIColor colorWithRed:51./255 green:51./255 blue:51./255 alpha:1];
    }
    return _cardLabel;
}

- (UIImageView *)cardImg {
    if (_cardImg == nil) {
        _cardImg = [[UIImageView alloc]init];
    }
    return _cardImg;
}

- (void)initUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.cardImg];
    [self addSubview:self.cardLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.center = CGPointMake(16 + CGRectGetWidth(self.titleLabel.bounds) /2 , CGRectGetHeight(self.bounds)/2);
    
    self.cardImg.center = CGPointMake(CGRectGetWidth(self.bounds) /2 , CGRectGetHeight(self.bounds)/2);
    
    [self.cardLabel sizeToFit];
    self.cardLabel.center = CGPointMake(CGRectGetWidth(self.bounds) - 16 - CGRectGetWidth(self.cardLabel.bounds) / 2, CGRectGetHeight(self.bounds)/2);
}

- (void)setCardId:(NSString *)cardId {
    self.cardLabel.text = cardId;
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

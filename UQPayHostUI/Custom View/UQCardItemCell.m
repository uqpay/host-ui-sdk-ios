//
//  UQCardItemCell.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/8.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQCardItemCell.h"
#import "../Helpers/SystemUtils.h"

#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

#define UQPADDING 20

@interface UQCardItemCell()
@end

@implementation UQCardItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconLabel = [UILabel new];
        self.iconLabel.font = [UIFont systemFontOfSize:24];
        self.cardTextLabel = [UILabel new];
        self.cardTextLabel.font = [UIFont systemFontOfSize:26];
        self.selectBtn = [UIButton new];
        self.revokeBtn = [UIButton new];
        
        [self.contentView addSubview:self.iconLabel];
        [self.contentView addSubview:self.cardTextLabel];
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.revokeBtn];
        
        [self.selectBtn setTitle:@"select" forState:UIControlStateNormal];
        [self.revokeBtn setTitle:@"revoke" forState:UIControlStateNormal];
        [self.revokeBtn setTitleColor:[UQUIKAppearance sharedInstance].errorForegroundColor forState:UIControlStateNormal];
        [self.selectBtn setTitleColor:[UQUIKAppearance sharedInstance].tintColor forState:UIControlStateNormal];
    }
    return self;
}
- (void)layoutSubviews {
    
    self.contentView.frame = CGRectMake(CGRectGetMinX(self.contentView.frame) + 5, CGRectGetMinY(self.contentView.frame) + 5, CGRectGetWidth(self.contentView.frame) - 5 * 2, CGRectGetHeight(self.contentView.frame) - 5 * 2);
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = [UQUIKAppearance sharedInstance].overlayColor.CGColor;
    
    [self.iconLabel sizeToFit];
    [self.cardTextLabel sizeToFit];
    [self.selectBtn sizeToFit];
    [self.revokeBtn sizeToFit];
    
    self.iconLabel.frame = CGRectMake(UQPADDING, UQPADDING, CGRectGetWidth(self.iconLabel.frame), CGRectGetHeight(self.iconLabel.frame));
    self.cardTextLabel.center = CGPointMake(SystemUtils.SCREEN_WIDTH - UQPADDING - CGRectGetWidth(self.cardTextLabel.frame) / 2,  self.iconLabel.center.y);
    
    self.selectBtn.center = CGPointMake(SystemUtils.SCREEN_WIDTH - UQPADDING - CGRectGetWidth(self.selectBtn.frame)/2, CGRectGetHeight(self.frame) - UQPADDING - CGRectGetHeight(self.selectBtn.frame)/2);
    
    self.revokeBtn.center = CGPointMake(CGRectGetMinX(self.selectBtn.frame) - UQPADDING - CGRectGetWidth(self.revokeBtn.frame)/2, self.selectBtn.center.y);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

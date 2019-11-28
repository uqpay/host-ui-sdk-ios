//
//  UQCardItemViewCell.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/15.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQCardItemViewCell.h"
#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

@interface UQCardItemViewCell()

@property (nonatomic) UIView *sepView;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation UQCardItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.sepView];
}


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UQUIKAppearance sharedInstance].cardTitleColor;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = [UQUIKAppearance sharedInstance].detailTitleColor;
    }
    return _detailLabel;
}

- (UIImageView *)selectView {
    if (_selectView == nil) {
        _selectView = [[UIImageView alloc]init];
        _selectView.image = [UQImageUtils selectIcon];
        _selectView.frame = CGRectMake(0, 0, 20, 20);
    }
    return _selectView;
}

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc]init];
    }
    return _iconView;
}

- (UIView *)sepView {
    if (_sepView == nil) {
        _sepView = [UIView new];
        _sepView.backgroundColor = [UQUIKAppearance sharedInstance].defaultTableSepColor;
    }
    return _sepView;
}

- (void)setIconImage:(NSString *)imageName {
    UIImage *image = [[UQImageUtils shareInstance].icons objectForKey:imageName];
    if (image != nil) {
        [self.iconView setImage:image];
        [self.iconView sizeToFit];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)layoutSubviews {
    [self.titleLabel sizeToFit];
    [self.detailLabel sizeToFit];
    
    self.iconView.frame = CGRectMake(12, 0, CGRectGetWidth(self.iconView.bounds), CGRectGetHeight(self.iconView.bounds));
    self.iconView.center = CGPointMake(self.iconView.center.x, CGRectGetHeight(self.contentView.bounds) / 2) ;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + 12, 0, CGRectGetWidth(self.titleLabel.bounds), CGRectGetHeight(self.titleLabel.bounds));
    self.titleLabel.center = CGPointMake(self.titleLabel.center.x, CGRectGetHeight(self.bounds) /2);
    
    self.detailLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) , 0, CGRectGetWidth(self.detailLabel.bounds), CGRectGetHeight(self.detailLabel.bounds));
    self.detailLabel.center = CGPointMake(self.detailLabel.center.x, CGRectGetHeight(self.bounds) /2);
    
    self.sepView.frame = CGRectMake(1.0, CGRectGetHeight(self.bounds) - 1, CGRectGetWidth(self.bounds) -2 , 1);
}

- (UIViewController *)viewController {
    UIResponder *responder = self;
    
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end

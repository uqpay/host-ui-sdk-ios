//
//  UQCardItemCell.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/8.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQCardItemCell : UITableViewCell


@property(nonatomic, strong) UIButton *selectBtn;
@property(nonatomic, strong) UIButton *revokeBtn;
@property(nonatomic, strong) UILabel  *cardTextLabel;
@property(nonatomic, strong) UILabel  *iconLabel;

@end

NS_ASSUME_NONNULL_END

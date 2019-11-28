//
//  UQUIKSelectCardView.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/7/5.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UQUIKAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface UQUIKSelectCardView : UIView

@property(nonatomic, strong) UILabel *textView;
- (void)addTarget:(id)target actoin:(SEL)action;

@end

NS_ASSUME_NONNULL_END

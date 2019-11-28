//
//  UQCardItemView.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/15.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQCardItemView : UIView


@property (nonatomic, setter=setCardId:) NSString* cardId;

- (void)setCardImageName:(NSString *)imageName;
- (void)addTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END

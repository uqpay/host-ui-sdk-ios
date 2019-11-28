//
//  UQUIKSMSFormField.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/7/19.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKFormField.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SendSuccess)(BOOL success);

@protocol UQUIKSMSFormFieldDelegate;
@interface UQUIKSMSFormField : UQUIKFormField
@property (nonatomic, weak) id<UQUIKSMSFormFieldDelegate> smsDelegate;
@end

@protocol UQUIKSMSFormFieldDelegate <NSObject>

- (void)sendSMS:(UIButton*)btn success:(SendSuccess)isSuccess;

@end

NS_ASSUME_NONNULL_END

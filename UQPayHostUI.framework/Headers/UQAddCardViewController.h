//
//  UQAddCardViewController.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/5.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UQHostUIBaseViewController.h"
#import "UQHttpClient.h"
#if __has_include ("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UQAddCardViewController : UQHostUIBaseViewController<UITextFieldDelegate, UQUIKFormFieldDelegate, UQUIKCardNumberFormFieldDelegate, UQUIKSMSFormFieldDelegate>


@end

NS_ASSUME_NONNULL_END

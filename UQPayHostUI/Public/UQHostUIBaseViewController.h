//
//  UQHostUIBaseViewController.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/4.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UQHostUIViewControllerDelegate;
@class UQHostResult;

NS_ASSUME_NONNULL_BEGIN

@interface UQHostUIBaseViewController : UIViewController

- (void)pushtoNavigationController:(UIViewController*)vc;
@property (nonatomic,weak) id<UQHostUIViewControllerDelegate> delegate;
@end

@protocol UQHostUIViewControllerDelegate<NSObject>

- (void)UQHostResult:(UQHostResult *)model;

@optional
- (void)UQHostError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

//
//  UQHostUIViewController.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/4.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UQHostUIBaseViewController.h"
#import "UQAddCardViewController.h"
#import "UQCardListViewController.h"
#import "UQHttpClient.h"


NS_ASSUME_NONNULL_BEGIN

@interface UQHostUIViewController : UQHostUIBaseViewController

@property (nonatomic) NSString* token;

- (instancetype)initWithModel:(UQClientModelType)modelType;
@end


NS_ASSUME_NONNULL_END


//
//  SMSModel.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/9.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMSModel : JSONModel
@property (nonatomic)NSString * uqOrderId;
@end

NS_ASSUME_NONNULL_END

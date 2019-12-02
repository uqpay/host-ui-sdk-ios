//
//  ResultModel.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/9.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultModel : JSONModel

@property (nonatomic) NSString *cardToken;
@property (nonatomic) NSString *issuer;
@property (nonatomic) NSString *panTail;

@end

NS_ASSUME_NONNULL_END

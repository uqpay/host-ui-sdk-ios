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

@property (nonatomic) NSString *date;
@property (nonatomic) NSString *issuer;
@property (nonatomic) NSString *panTail;
@property (nonatomic) NSString *respCode;
@property (nonatomic) NSString *respMessage;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *uuid;

@end

NS_ASSUME_NONNULL_END

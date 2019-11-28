//
//  UQHttpClient.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/8.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddCardModel;

typedef NS_ENUM(NSInteger, UQClientModelType)
{
    TESTTYPE = 0,
    PROTYPE,
    LOCALTYPE
};

NS_ASSUME_NONNULL_BEGIN

@interface UQHttpClient : NSObject

typedef void(^SuccessBlock)(NSDictionary*dict, BOOL isSuccess);
typedef void (^FailureBlock)(NSError * error);

+ (instancetype) sharedInstance;

- (void)setModelType:(UQClientModelType)modelType;

- (void)setToken:(NSString*)token;

- (void)getCardList:(SuccessBlock)success fail:(FailureBlock)fail;

- (void)postCardRevoke:(NSDictionary*)dic success:(SuccessBlock)success fail:(FailureBlock)fail;

- (void)getSms:(NSDictionary*)dic success:(SuccessBlock)success fail:(FailureBlock)fail;

- (void)addCard:(AddCardModel*)model success:(SuccessBlock)success fail:(FailureBlock)fail;

+ (void)getToken:(SuccessBlock)success fail:(FailureBlock)fail;


@end

NS_ASSUME_NONNULL_END

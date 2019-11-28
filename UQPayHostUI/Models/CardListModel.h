//
//  CardListModel.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/10.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardListModel : JSONModel

@property (nonatomic) NSArray<ResultModel *>* data;

@end

NS_ASSUME_NONNULL_END

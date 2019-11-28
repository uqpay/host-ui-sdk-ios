//
//  UQCardListTableView.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/15.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQCardListTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

typedef void(^ DeleteCard)(NSInteger index);
@property (nonatomic) NSMutableArray *data;
@property (nonatomic,weak) UIViewController *vc;
@property (nonatomic,copy) DeleteCard deleteCard;

@end

NS_ASSUME_NONNULL_END

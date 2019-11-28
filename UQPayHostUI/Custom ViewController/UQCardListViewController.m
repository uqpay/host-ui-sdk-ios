//
//  UQCardListViewController.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/5.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQCardListViewController.h"
#import "../Helpers/SystemUtils.h"
#import "../Models/CardListModel.h"
#import "../Public/UQHostResult.h"
#import "../Custom View/UQCardListTableView.h"

#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif



@interface UQCardListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UQCardListTableView *tableView;

@end

@implementation UQCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    self.view.backgroundColor = [UQUIKAppearance sharedInstance].barBackgroundColor;
    
    self.navigationItem.leftBarButtonItem = [[UQUIKBarButtonItem alloc]initWithImage:[UQImageUtils backIcon] style:UIBarButtonItemStylePlain target:self action:@selector(cancelTapped)];
    self.navigationItem.leftBarButtonItem.tintColor = [UQUIKAppearance sharedInstance].navigationBarBackItemColor;
    self.title = UQUIKLocalizedString(UQ_SELECT_CARD);
    self.navigationItem.rightBarButtonItem = [[UQUIKBarButtonItem alloc]initWithTitle:UQUIKLocalizedString(ADD_CARD_ACTION) style:UIBarButtonItemStylePlain target:self action:@selector(addCard)];
    
    [self.view addSubview:self.tableView];
}


#pragma mark --lazy init --
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UQCardListTableView alloc]initWithFrame:CGRectMake(0, 0, SystemUtils.SCREEN_WIDTH, SystemUtils.SCREEN_HEIGHT)
                                                 style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.data = self.data;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.vc = self;
        _tableView.deleteCard = ^(NSInteger index) {
            [[UQHttpClient sharedInstance]postCardRevoke:@{@"cardToken": [self.data[index] objectForKey:@"uuid"] } success:^(NSDictionary * _Nonnull dict, BOOL isSuccess) {
                if (isSuccess && dict != nil) {
                    if ([[dict objectForKey:@"status"] intValue] == 200) {
                        [self.data removeObjectAtIndex:index];
                        self->_tableView.data = self.data;
                        [self->_tableView reloadData];
                    }
                }
            } fail:^(NSError * _Nonnull error) {
    
            }];
        };
    }
    return _tableView;
}

-(void)cancelTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCard {
    UQAddCardViewController *viewController = [[UQAddCardViewController alloc]init];
    [self pushtoNavigationController:viewController];
}

@end

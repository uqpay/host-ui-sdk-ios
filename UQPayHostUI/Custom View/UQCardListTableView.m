//
//  UQCardListTableView.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/15.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQCardListTableView.h"
#import "../Public/UQHostResult.h"
#import "../Custom View/UQCardItemViewCell.h"
#import "../Public/UQCardListViewController.h"
#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

#define CELL_IDENTIFIER @"uq_card_item_id"

@implementation UQCardListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - delegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UQCardItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if (cell == nil) {
        cell = [[UQCardItemViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"**** %@ ",[self.data[indexPath.row] objectForKey:@"panTail"]];
    [cell setIconImage:[self.data[indexPath.row] objectForKey:@"issuer"]];
    return cell;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self unBindCard:indexPath.row];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UQCardListViewController *viewController = (UQCardListViewController*)self.vc;
    [viewController dismissViewControllerAnimated:YES completion:nil];
    if (viewController.delegate) {
        UQHostResult *result = [[UQHostResult alloc]initWithDictionary:self.data[indexPath.row] error:nil];
        [viewController.delegate UQHostResult:result];
    }
    
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        completionHandler(YES);
        [self unBindCard:indexPath.row];
    }];
    deleteRowAction.image = [UQImageUtils deleteIcon];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}


- (void)unBindCard:(NSInteger)index {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:UQUIKLocalizedString(UQ_UNBIND_CARD_MESSAGE) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:UQUIKLocalizedString(CANCEL_ACTION)style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:UQUIKLocalizedString(TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.deleteCard != nil) {
            self.deleteCard(index);
        }
    }]];
    [self.vc presentViewController:alertController animated:YES completion:nil];
    
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [super insertSubview:view atIndex:index];
    if ([view isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
        for (UIButton *btn in view.subviews) {
            
            if ([btn isKindOfClass:[UIButton class]]) {
                [btn setBackgroundColor:[UIColor orangeColor]];
                
                [btn setTitle:nil forState:UIControlStateNormal];
                
                UIImage *img = [UQImageUtils deleteIcon];
                [btn setImage:img forState:UIControlStateNormal];
                [btn setImage:img forState:UIControlStateHighlighted];
                
                [btn setTintColor:[UIColor whiteColor]];
            }
        }
    }
}
@end

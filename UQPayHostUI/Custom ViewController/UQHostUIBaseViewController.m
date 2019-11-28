//
//  UQHostUIBaseViewController.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/4.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQHostUIBaseViewController.h"

#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

@interface UQHostUIBaseViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *activityIndicatorWrapperView;
@property (nonatomic, strong) UILabel *titleView;

@end

@implementation UQHostUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicatorWrapperView = [[UIView alloc] init];
    self.activityIndicatorWrapperView.backgroundColor = [UIColor clearColor];
    self.activityIndicatorWrapperView.hidden = YES;
    [self.view addSubview:self.activityIndicatorWrapperView];
    self.activityIndicatorWrapperView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[activityWrapper]|" options:0 metrics:nil views:@{@"activityWrapper": self.activityIndicatorWrapperView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[activityWrapper]|" options:0 metrics:nil views:@{@"activityWrapper": self.activityIndicatorWrapperView}]];
    
    self.activityIndicatorView = [UIActivityIndicatorView new];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicatorView.activityIndicatorViewStyle = [UQUIKAppearance sharedInstance].activityIndicatorViewStyle;
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorWrapperView addSubview:self.activityIndicatorView];
    [self.activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.activityIndicatorWrapperView.centerXAnchor].active = YES;
    [self.activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.activityIndicatorWrapperView.centerYAnchor].active = YES;
    
    self.titleView = [UQUIKAppearance styledNavigationTitleLabel];
    self.titleView.text = self.title;
    self.titleView.font = [UIFont systemFontOfSize:17];
    self.titleView.textColor = [UQUIKAppearance sharedInstance].cardTitleColor;
    self.navigationItem.titleView = self.titleView;
}

- (void)showLoadingScreen:(BOOL)show animated:(BOOL)animated {
    if (show) {
        [self.view bringSubviewToFront:self.activityIndicatorWrapperView];
    }
    
    if (animated) {
        [UIView transitionWithView:self.activityIndicatorWrapperView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.activityIndicatorWrapperView.hidden = !show;
        } completion:nil];
    } else {
        self.activityIndicatorWrapperView.hidden = !show;
    }
}

- (void)showLoadingScreen:(BOOL)show {
    if (show) {
        [self.view bringSubviewToFront:self.activityIndicatorWrapperView];
    }
    self.activityIndicatorWrapperView.hidden = !show;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    if (self.titleView) {
        self.titleView.text = self.title;
    }
}

#pragma mark - UI Preferences

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)pushtoNavigationController:(UQHostUIBaseViewController*)vc {
    vc.delegate = self.delegate;
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
    } else {
        navController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:navController animated:true completion:NULL];
}


@end

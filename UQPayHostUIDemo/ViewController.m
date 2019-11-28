//
//  ViewController.m
//  UQPayHostUIDemo
//
//  Created by uqpay on 2019/7/4.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "ViewController.h"
#import "WHToast.h"

#import <UQPayHostUI/UQPayHostUI.h>

@interface ViewController ()<UQHostUIViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong )UQHostUIViewController *hostViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)openUI:(id)sender {
    
    self.hostViewController = [[UQHostUIViewController alloc]initWithModel:TESTTYPE];
    self.hostViewController.token = self.textField.text;
    self.hostViewController.delegate = self;
    [self presentViewController:self.hostViewController animated:true completion:NULL];
}

- (void)UQHostResult:(UQHostResult *)model {
    NSLog(@"panTail = %@", model.panTail);
    NSLog(@"cardToken = %@",model.cardToken);
    NSLog(@"ussuer = %@", model.issuer);
    [self.hostViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)UQHostError:(NSError *)error {
     [WHToast showMessage:[error localizedDescription] originY:([UIScreen mainScreen].bounds.size.height - 100) duration:2 finishHandler:nil];
}

@end

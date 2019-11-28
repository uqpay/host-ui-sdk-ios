//
//  UQUIKCardVectorArtView.m
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKCardVectorArtView.h"

@implementation UQUIKCardVectorArtView

- (id)init {
    self = [super init];
    if (self) {
        self.artDimensions = CGSizeMake(45.0f, 29.0f);
        self.opaque = NO;
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
}

@end

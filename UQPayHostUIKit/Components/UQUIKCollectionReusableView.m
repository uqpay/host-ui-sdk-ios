#import "UQUIKCollectionReusableView.h"
#import "UQUIKAppearance.h"

@implementation UQUIKCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:12];
        self.label.textColor = [UQUIKAppearance sharedInstance].secondaryTextColor;
        [self addSubview:self.label];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"label":self.label}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"label":self.label}]];
        
    }
    return self;
}

@end

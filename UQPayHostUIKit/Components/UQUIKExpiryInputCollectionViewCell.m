#import "UQUIKExpiryInputCollectionViewCell.h"
#import "UQUIKAppearance.h"

@implementation UQUIKExpiryInputCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.backgroundColor = [UQUIKAppearance sharedInstance].formFieldBackgroundColor;
        self.label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:24];
        self.label.textColor = [UQUIKAppearance sharedInstance].primaryTextColor;
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        
        UIView* bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.layer.cornerRadius = 4;
        self.selectedBackgroundView = bgView;
        self.selectedBackgroundView.backgroundColor = [[UQUIKAppearance sharedInstance].primaryTextColor colorWithAlphaComponent:0.1];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"label":self.label}]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"label":self.label}]];
        
    }
    return self;
}

- (NSInteger)getInteger {
    return [self.label.text integerValue];
}

@end

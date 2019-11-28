#import "UQDropInUIUtilities.h"

@implementation UQDropInUIUtilities

+ (UIView *)addSpacerToStackView:(UIStackView*)stackView beforeView:(UIView*)view size:(float)size {
    NSInteger indexOfView = [stackView.arrangedSubviews indexOfObject:view];
    if (indexOfView != NSNotFound) {
        UIView *spacer = [[UIView alloc] init];
        spacer.translatesAutoresizingMaskIntoConstraints = NO;
        [stackView insertArrangedSubview:spacer atIndex:indexOfView];
        NSLayoutConstraint *heightConstraint = [spacer.heightAnchor constraintEqualToConstant:size];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        heightConstraint.active = true;
        return spacer;
    }
    return nil;
}

+ (UIStackView *)newStackView {
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis  = UILayoutConstraintAxisVertical;
    stackView.distribution  = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 0;
    return stackView;
}

+ (UIStackView *)newStackViewForError:(NSString*)errorText {
    UIStackView *newStackView = [self newStackView];
    UILabel *errorLabel = [UILabel new];
    errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [UQUIKAppearance styleSmallLabelPrimary:errorLabel];
    errorLabel.textColor = [UQUIKAppearance sharedInstance].errorForegroundColor;
    errorLabel.text = errorText;
    newStackView.layoutMargins = UIEdgeInsetsMake([UQUIKAppearance verticalFormSpaceTight], [UQUIKAppearance horizontalFormContentPadding], [UQUIKAppearance verticalFormSpaceTight], [UQUIKAppearance horizontalFormContentPadding]);
    newStackView.layoutMarginsRelativeArrangement = true;
    [newStackView addArrangedSubview:errorLabel];
    return newStackView;
}

@end

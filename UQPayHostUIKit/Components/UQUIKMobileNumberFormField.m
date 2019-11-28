#import "UQUIKMobileNumberFormField.h"
#import "UQUIKTextField.h"
#import "UQUIKInputAccessoryToolbar.h"
#import "UQUIKLocalizedString.h"

@implementation UQUIKMobileNumberFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = UQUIKLocalizedString(MOBILE_NUMBER_LABEL);
        self.formLabel.text = [NSString stringWithFormat:@"%@:",UQUIKLocalizedString(MOBILE_NUMBER_LABEL) ];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (void)fieldContentDidChange {
    [self.delegate formFieldDidChange:self];
    [self updateAppearance];
}

#pragma mark - Custom accessors

- (BOOL)valid {
    return self.mobileNumber.length >= 8;
}

- (NSString *)mobileNumber {
    return self.textField.text;
}

@end

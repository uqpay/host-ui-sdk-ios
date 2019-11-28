#import "UQUIKCardholderNameFormField.h"
#import "UQUIKLocalizedString.h"

@implementation UQUIKCardholderNameFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = UQUIKLocalizedString(CARDHOLDER_NAME_LABEL);
        self.formLabel.text = UQUIKLocalizedString(CARDHOLDER_NAME_LABEL);

        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        self.textField.returnKeyType = UIReturnKeyNext;
    }

    return self;
}

- (NSString *)cardholderName {
    return self.textField.text;
}

- (BOOL)valid {
    if (self.isRequired) {
        return [self.cardholderName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet].length > 0;
    }
    else {
        return YES;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return newText.length <= 255;
}

@end

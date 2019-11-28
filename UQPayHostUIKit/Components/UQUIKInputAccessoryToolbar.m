#import "UQUIKInputAccessoryToolbar.h"
#import <UIKit/UIKit.h>
#import "UIColor+UQUIK.h"

@implementation UQUIKInputAccessoryToolbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.barStyle = UIBarStyleDefault;
        self.translucent = YES;
        self.barTintColor = [UIColor uquik_colorFromHex:@"FFFFFF" alpha:0.88];
        self.tintColor = [UIColor uquik_colorFromHex:@"858E99" alpha:1.0];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (instancetype)initWithDoneButtonForInput:(id <UITextInput>)input {
    if (self = [self init]) {
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:input action:@selector(endEditing:)];
        self.items = @[flexSpace, doneButton];
    }
    return self;
}

@end

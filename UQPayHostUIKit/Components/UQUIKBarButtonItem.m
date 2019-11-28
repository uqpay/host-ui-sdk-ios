#import "UQUIKBarButtonItem.h"
#import "UQUIKAppearance.h"

@implementation UQUIKBarButtonItem

- (instancetype)init {
    if (self = [super init]) {
        [self updateTitleTextAttributes];
    }
    return self;
}

- (void)setBold:(BOOL)bold {
    _bold = bold;
    [self updateTitleTextAttributes];
}

- (void)updateTitleTextAttributes {
    NSString *fontName = self.bold ? [UQUIKAppearance sharedInstance].boldFontFamily : [UQUIKAppearance sharedInstance].fontFamily;
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UQUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UQUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateNormal | UIControlStateHighlighted];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UQUIKAppearance sharedInstance].disabledColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateDisabled];
}

@end

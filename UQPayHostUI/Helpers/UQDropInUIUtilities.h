#import <UIKit/UIKit.h>
#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif

@interface UQDropInUIUtilities : NSObject

+ (UIView *)addSpacerToStackView:(UIStackView*)stackView beforeView:(UIView*)view size:(float)size;
+ (UIStackView *)newStackView;
+ (UIStackView *)newStackViewForError:(NSString*)errorText;

@end

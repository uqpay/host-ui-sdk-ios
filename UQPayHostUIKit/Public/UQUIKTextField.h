#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UQUIKTextFieldEditDelegate;

/// @class A specialized text field that provides more granular callbacks than a standard
/// UITextField as the user edits text
@interface UQUIKTextField : UITextField

/// The specialized delegate for receiving callbacks about editing
@property (nonatomic, weak) id<UQUIKTextFieldEditDelegate> editDelegate;

@property (nonatomic) BOOL hideCaret;

@end

/// A protocol for receiving callbacks when a user edits text in a `UQUITextField`
@protocol UQUIKTextFieldEditDelegate <NSObject>

@optional

/// The editDelegate receives this message when the user deletes a character, but before the deletion
/// is applied to the `text`
///
/// @param textField The text field
- (void)textFieldWillDeleteBackward:(UQUIKTextField *)textField;

/// The editDelegate receives this message after the user deletes a character
///
/// @param textField    The text field
/// @param originalText The `text` of the text field before applying the deletion
- (void)textFieldDidDeleteBackward:(UQUIKTextField *)textField
                      originalText:(NSString *)originalText;

/// The editDelegate receives this message when the user enters text, but
/// before the text is inserted
///
/// @param textField The text field
/// @param text      The text that will be inserted
- (void)textField:(UQUIKTextField *)textField willInsertText:(NSString *)text;

/// The editDelegate receives this message after the user enters text
///
/// @param textField The text field
/// @param text      The text that was inserted
- (void)textField:(UQUIKTextField *)textField didInsertText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END

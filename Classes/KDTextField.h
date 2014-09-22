//
//  KDTextField.h
//  KDTextField
//
//  Created by Kedar Desai on 18/09/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KDTextField;

typedef enum {
    
    kTextFieldTypeDefault, // Default
    kTextFieldTypeEmail, // For email-id as text
    kTextFieldTypeNumber, // For numberic textField
    kTextFieldTypeDecimalNumber, // For decimal numberic textField
    kTextFieldTypeString, // Only for string without symbols and number
    kTextFieldTypePassword,
    kTextFieldTypeSSN, // For set format _ _ _ _ or _ _ _ - _ _ _ like this
    kTextFieldTypeCustom
    
} KDTextFieldType;

@protocol KDTextFieldDelegate <UITextFieldDelegate>// <NSObject>

@optional
- (void)onError:(NSError *)error withTextField:(UITextField *)textField;
- (void)onSucess:(KDTextField *)textField;
- (void)doneWithNumberPad:(KDTextField *)textField;
- (void)addCustomValidation:(KDTextField *)textField;

@end

@interface KDTextField : UITextField // <UITextFieldDelegate>

@property (nonatomic) KDTextFieldType textFieldtype;
@property (nonatomic, setter = setClearIfInValid:) BOOL clearIfInValid;
@property (nonatomic) BOOL isAnimated;
@property (nonatomic) BOOL isMultipleEmailAddresses;
@property (nonatomic, weak) id <KDTextFieldDelegate> delegate;

- (id)initWithType:(KDTextFieldType)textFieldtype;
- (void)validateTextFieldAnimated:(BOOL)isAnimated;
- (void)setNormalBorderColor:(UIColor *)normalBorderColor errorBorderColor:(UIColor *)errorBorderColor normalTextColor:(UIColor *)normalTextColor errorTextColor:(UIColor *)errorTextColor normalBorderWidth:(CGFloat)normalBorderWidth errorBorderWidth:(CGFloat)errorBorderWidth;

@end

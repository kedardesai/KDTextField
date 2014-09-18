//
//  KDTextField.h
//  KDTextField
//
//  Created by Kedar Desai on 18/09/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    kTextFieldTypeDefault, // Default
    kTextFieldTypeEmail, // For email-id as text
    kTextFieldTypeNumber, // For numberic textField
    kTextFieldTypeString, // Only for string without symbols and number
    kTextFieldTypePassword,
    kTextFieldTypeSSN // For set format _ _ _ _ or _ _ _ - _ _ _ like this
    
} KDTextFieldType;

@protocol KDTextFieldDelegate <NSObject>

@optional
- (void)onError:(NSError *)error;
- (void)onSucess:(BOOL)success;

@end

@interface KDTextField : UITextField

@property (nonatomic) KDTextFieldType textFieldtype;
@property (nonatomic, strong) id <KDTextFieldDelegate> kdDelegate;

- (id)initWithType:(KDTextFieldType)textFieldtype;

- (void)validateTextFieldAnimated:(BOOL)isAnimated;

@end

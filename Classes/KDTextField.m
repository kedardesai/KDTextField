//
//  KDTextField.m
//  KDTextField
//
//  Created by Kedar Desai on 18/09/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KDTextField.h"

NSString *const KDTextFieldDomain = @"KD.KDTextField";
NSString *const ERROR_EMPTY_TEXTFIELD = @"Textfield is empty"; // Code : 1001
NSString *const ERROR_INVALID_EMAIL = @"Invalid email-id entered."; // Code : 1002
NSString *const ERROR_INVALID_NUMBER = @"Invalid number entered."; // Code : 1003
NSString *const ERROR_INVALID_DECIMAL_NUMBER = @"Invalid decimal number entered."; // Code : 1004
NSString *const ERROR_INVALID_STRING = @"Invalid string entered."; // Code : 1005

@interface KDTextField ()

@property (nonatomic, strong) NSError *inValidError;
@property (nonatomic, strong) UIColor *normalBorderColor;
@property (nonatomic, strong) UIColor *errorBorderColor;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *errorTextColor;
@property (nonatomic) CGFloat normalBorderWidth;
@property (nonatomic) CGFloat errorBorderWidth;
@property (nonatomic) NSInteger direction;
@property (nonatomic) NSInteger shakes;

- (void)commonInit;
- (void)setTextFieldStyleWithType;
- (void)numberPadDoneButtonClicked:(UIBarButtonItem *)doneButton;
- (void)createErrorWithLocalisedDescription:(NSString *)localisedDescription andCode:(NSInteger)code;
- (BOOL)isTextNonEmpty;
- (BOOL)isTextValidEmailId;
- (BOOL)isTextValidNumber;
- (BOOL)isTextValidDecimalNumber;
- (BOOL)isTextValidString;

@end

@implementation KDTextField

#pragma mark UIViewLifeCycle Methods

- (id)init
{
    self = [super init];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithType:(KDTextFieldType)textFieldtype
{
    self = [super init];
    
    if (self) {
        self.textFieldtype = textFieldtype;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

#pragma mark Self-Written Methods

- (void)commonInit
{
    if (!self.textFieldtype) {
        self.textFieldtype = kTextFieldTypeDefault;
    }
    
    self.normalBorderColor = nil;
    self.normalTextColor = nil;
    
    self.errorBorderColor = nil;
    self.errorTextColor = nil;
    
    self.clearIfInValid = YES;
    self.isAnimated = NO;
    self.isMultipleEmailAddresses = NO;
}

- (void)setTextFieldStyleWithType
{
    switch (self.textFieldtype) {
            
        case kTextFieldTypeDefault:
        {
            [self setKeyboardType:UIKeyboardTypeDefault];
        }
            break;
            
        case kTextFieldTypeEmail:
        {
            [self setKeyboardType:UIKeyboardTypeEmailAddress];
        }
            break;
            
        case kTextFieldTypeNumber:
        {
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(numberPadDoneButtonClicked:)],
                                   nil];
            [numberToolbar sizeToFit];
            [self setInputAccessoryView:numberToolbar];
        }
            break;
            
        case kTextFieldTypeDecimalNumber:
        {
            [self setKeyboardType:UIKeyboardTypeDecimalPad];
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(numberPadDoneButtonClicked:)],
                                   nil];
            [numberToolbar sizeToFit];
            [self setInputAccessoryView:numberToolbar];
        }
            break;
            
        case kTextFieldTypeString:
        {
            [self setKeyboardType:UIKeyboardTypeAlphabet];
        }
            break;
            
        case kTextFieldTypePassword:
        {
            [self setSecureTextEntry:YES];
            [self setKeyboardType:UIKeyboardTypeDefault];
        }
            break;
            
        case kTextFieldTypeSSN:
        {
            [self setKeyboardType:UIKeyboardTypeDefault];
        }
            break;
            
        case kTextFieldTypeCustom:
        {
            [self setKeyboardType:UIKeyboardTypeDefault];
        }
            break;
            
        default:
            [self setKeyboardType:UIKeyboardTypeDefault];
            break;
    }
}

- (void)createErrorWithLocalisedDescription:(NSString *)localisedDescription andCode:(NSInteger)code
{
    NSError *error = nil;
    NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionary];
    [userInfoDict setValue:localisedDescription forKey:NSLocalizedDescriptionKey];
    error = [NSError errorWithDomain:KDTextFieldDomain code:code userInfo:userInfoDict];
    self.inValidError = error;
}

#pragma mark Public Property Setter Methods

- (void)setTextFieldtype:(KDTextFieldType)textFieldtype
{
    if (self.textFieldtype != textFieldtype) {
        _textFieldtype = textFieldtype;
        [self setTextFieldStyleWithType];
    }
}

#pragma mark Private Property Setter Methods

- (void)setNormalBorderColor:(UIColor *)normalBorderColor
{
    if (_normalBorderColor!=normalBorderColor) {
        _normalBorderColor = normalBorderColor;
        [[self layer] setBorderColor:_normalBorderColor.CGColor];
    }
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    if (_normalTextColor!=normalTextColor) {
        _normalTextColor = normalTextColor;
        [self setTextColor:_normalTextColor];
    }
}

- (void)setNormalBorderWidth:(CGFloat)normalBorderWidth
{
    if (_normalBorderWidth!=normalBorderWidth) {
        _normalBorderWidth = normalBorderWidth;
        [[self layer] setBorderWidth:_normalBorderWidth];
    }
}

#pragma mark Public Methods

- (void)validateTextFieldAnimated:(BOOL)isAnimated
{
    // Validate textField and if Animated make the border red or keep same border
    
    self.isAnimated = isAnimated;
    
    if (![self isTextNonEmpty]) { // In case text property of textField is empty
        if (self.isAnimated) { // In case developer allows animation in color and automation in user entry.
            if (self.errorBorderWidth>0.0f) {
                [[self layer] setBorderColor:[self.errorBorderColor CGColor]];
                [[self layer] setBorderWidth:self.errorBorderWidth];
            }
            if (self.errorTextColor) {
                [self setTextColor:self.errorTextColor];
            }
            self.direction = 1;
            self.shakes = 0;
            [self shakeTextField];
        }
        
        [self.delegate onError:self.inValidError withTextField:self];
        
        return;
    }
    
    BOOL isValid = NO;
    
    switch (self.textFieldtype) {
        case kTextFieldTypeEmail:
            isValid = [self isTextValidEmailId]; // Validate if text entered is email or not.
            break;
            
        case kTextFieldTypeNumber:
            isValid = [self isTextValidNumber]; // Validate if text entered is number or not.
            break;
            
        case kTextFieldTypeDecimalNumber:
            isValid = [self isTextValidDecimalNumber]; // Validate if text entered is decimal number or not.
            break;
            
        case kTextFieldTypeString:
            isValid = [self isTextValidString]; // Validate if text entered is string or not.
            break;
            
        case kTextFieldTypeCustom:
        {
            [self.delegate addCustomValidation:self]; // Add some custom validation on developer's end.
            return;
        }
            break;
            
        default:
            isValid = YES;
            break;
    }
    
    if (!isValid) { // In case textField.text is not valid
        
        if (self.clearIfInValid) {
            [self setText:@""];
        }
        
        if (self.isAnimated) { // In case developer allows animation in color and automation in user entry.
            if (self.errorBorderWidth>0.0f) {
                [[self layer] setBorderColor:[self.errorBorderColor CGColor]];
                [[self layer] setBorderWidth:self.errorBorderWidth];
            }
            if (self.errorTextColor) {
                [self setTextColor:self.errorTextColor];
            }
            self.direction = 1;
            self.shakes = 0;
            [self shakeTextField];
        }
        
        [self.delegate onError:self.inValidError withTextField:self];
        
    } else { // In case textField.text is valid
        if (self.normalTextColor) {
            [self setTextColor:self.normalTextColor];
        }
        if (self.normalBorderWidth>0.0f) {
            [[self layer] setBorderColor:self.normalBorderColor.CGColor];
            [[self layer] setBorderWidth:self.normalBorderWidth];
        }
        [self.delegate onSucess:self];
    }
}

- (void)setNormalBorderColor:(UIColor *)normalBorderColor errorBorderColor:(UIColor *)errorBorderColor normalTextColor:(UIColor *)normalTextColor errorTextColor:(UIColor *)errorTextColor normalBorderWidth:(CGFloat)normalBorderWidth errorBorderWidth:(CGFloat)errorBorderWidth
{
    if (normalBorderColor) {
        self.normalBorderColor = normalBorderColor;
    }
    
    if (errorBorderColor) {
        self.errorBorderColor = errorBorderColor;
    }
    
    if (normalTextColor) {
        self.normalTextColor = normalTextColor;
    }
    
    if (errorTextColor) {
        self.errorTextColor = errorTextColor;
    }
    
    if (normalBorderWidth) {
        self.normalBorderWidth = normalBorderWidth;
    }
    
    if (errorBorderWidth) {
        self.errorBorderWidth = errorBorderWidth;
    }
}

- (void)shakeTextField
{
    
    [UIView animateWithDuration:0.03 animations:^ {
        
        self.transform = CGAffineTransformMakeTranslation(5*self.direction, 0);
        
    } completion:^(BOOL finished) {
        
        if(self.shakes >= 10)
        {
            self.transform = CGAffineTransformIdentity;
            return;
        }
        self.shakes++;
        self.direction = self.direction * -1;
        [self shakeTextField];
        
    }];
}

#pragma mark UIAction Methods

- (void)numberPadDoneButtonClicked:(UIBarButtonItem *)doneButton
{
    [self validateTextFieldAnimated:self.isAnimated];
    
    if (!self.inValidError) { // In case textField.text is valid
        [self.delegate doneWithNumberPad:self];
        [self resignFirstResponder];
    }
}

#pragma mark Text-Validation Methods

- (BOOL)isTextNonEmpty
{
    if ([[self text] length] == 0) { // In case text property of textField is Empty
        [self createErrorWithLocalisedDescription:ERROR_EMPTY_TEXTFIELD andCode:1001];
        return NO;
    }
    
    return YES;
}

- (BOOL)isTextValidEmailId
{
    if (!self.isMultipleEmailAddresses) { // In case multiple Email address separated by commas not allowed
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        BOOL isValid = [emailTest evaluateWithObject:self.text];
        if (!isValid) {
            [self createErrorWithLocalisedDescription:ERROR_INVALID_EMAIL andCode:1002];
            return NO;
        }
        return YES;
        
    } else {
        
        NSMutableArray *validEmails = [[NSMutableArray alloc] init];
        NSArray *emailArray = [self.text componentsSeparatedByString:@","];
        for (NSString *email in emailArray)
        {
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            if ([emailTest evaluateWithObject:email])
                [validEmails addObject:email];
            else {
                [self createErrorWithLocalisedDescription:ERROR_INVALID_EMAIL andCode:1002];
                return NO;
            }
            
        }
        return YES;
    }
}

- (BOOL)isTextValidNumber
{
    NSString *numberRegex = @"[0-9]*";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL isValid = [numberTest evaluateWithObject:self.text];
    if (!isValid) {
        [self createErrorWithLocalisedDescription:ERROR_INVALID_NUMBER andCode:1003];
        return NO;
    }
    return YES;
}

- (BOOL)isTextValidDecimalNumber
{
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self.text];
    if (![alphaNums isSupersetOfSet:inStringSet]) {
        [self createErrorWithLocalisedDescription:ERROR_INVALID_DECIMAL_NUMBER andCode:1004];
        return NO;
    }
    
    return YES;
}

- (BOOL)isTextValidString
{
    NSString *stringRegex = @"[a-z A-Z]*";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    BOOL isValid = [stringTest evaluateWithObject:self.text];
    if (!isValid) {
        [self createErrorWithLocalisedDescription:ERROR_INVALID_STRING andCode:1005];
        return NO;
    }
    return YES;
}

@end

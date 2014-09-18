//
//  KDTextField.m
//  KDTextField
//
//  Created by Kedar Desai on 18/09/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import "KDTextField.h"

@interface KDTextField ()

- (void)commonInit;
- (void)setTextFieldStyleWithType;

@end

@implementation KDTextField

NSString *const KDTextFieldDomain = @"KD.KDTextField";

#pragma mark UIViewLifeCycle Methods

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

#pragma mark Self-Written Methods

- (void)commonInit
{
    if (!self.textFieldtype) {
        self.textFieldtype = kTextFieldTypeDefault;
    }
}

- (void)setTextFieldStyleWithType
{
    
}

#pragma mark Setter Methods

- (void)setTextFieldtype:(KDTextFieldType)textFieldtype
{
    if (_textFieldtype != textFieldtype) {
        _textFieldtype = textFieldtype;
        [self setTextFieldStyleWithType];
    }
}

#pragma mark Public Methods

- (void)validateTextFieldAnimated:(BOOL)isAnimated
{
    // Validate textField and if Animated make the border red or keep same border
}

@end

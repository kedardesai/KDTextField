//
//  KDViewController.m
//  KDTextField
//
//  Created by Kedar Desai on 18/09/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import "KDViewController.h"

@interface KDViewController ()

@end

@implementation KDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.kdTextField setTextFieldtype:kTextFieldTypeEmail];
    [self.kdTextField setNormalBorderColor:[UIColor blueColor] errorBorderColor:[UIColor redColor] normalTextColor:[UIColor grayColor] errorTextColor:[UIColor grayColor] normalBorderWidth:1.0f errorBorderWidth:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark KDTextFieldDelegate Methods

- (void)onError:(NSError *)error withTextField:(KDTextField *)textField
{
    NSLog(@"ERROR ::: %@",[error localizedDescription]);
}

- (void)onSucess:(KDTextField *)textField
{
    NSLog(@"textField.text ::: %@", textField.text);
}

#pragma mark IBAction Methods

- (IBAction)validateButtonClicked:(id)sender
{
    // To Validate textField's text
    [self.kdTextField validateTextFieldAnimated:YES];
}

#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end

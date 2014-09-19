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
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark KDTextFieldDelegate Methods

- (void)onError:(NSError *)error withTextField:(UITextField *)textField
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
    
}

@end

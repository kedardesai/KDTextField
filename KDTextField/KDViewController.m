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
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",[[NSBundle mainBundle] bundleIdentifier]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

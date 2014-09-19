//
//  KDViewController.h
//  KDTextField
//
//  Created by Kedar Desai on 18/09/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDTextField.h"

@interface KDViewController : UIViewController <KDTextFieldDelegate>

@property (nonatomic, strong) IBOutlet KDTextField *kdTextField;

- (IBAction)validateButtonClicked:(id)sender;

@end

//
//  SimpleLoginViewController.h
//  SimpleLogin
//
//  Created by Su Yan Fang on 7/9/13.
//  Copyright (c) 2013 Su Yan Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleLoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextView *userInfo;
@property NSMutableData *responseData;
- (IBAction)login:(id)sender;
- (IBAction)performLogin:(id)sender;
- (void)loginFailed;
@end

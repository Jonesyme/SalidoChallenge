//
//  CreateAccountVC.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountVC : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIButton *createAccountBtn;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UITextField *pinTxt;
@property (nonatomic, weak) IBOutlet UITextField *firstNameTxt;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTxt;
@property (nonatomic, weak) IBOutlet UITextField *emailTxt;

/** 
 Create new account action
 */
-(IBAction)createAccountBtnTapped:(id)sender;

/**
 Animate the fading in/out of the error-message label
 */
-(void)animateMessageLabelFadeOut;

@end

//
//  CreateAccountVC.m
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "CreateAccountVC.h"
#import "AccountManager.h"
#define kPINTextFieldTag 664

@implementation CreateAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _pinTxt.tag = kPINTextFieldTag;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _messageLabel.text = @"";
}

-(void)createAccountBtnTapped:(id)sender {
    // error check inputs
    if(_pinTxt.text.length==0 || _firstNameTxt.text.length==0 || _lastNameTxt.text.length==0) {
        _messageLabel.text = @"Please complete all required fields";
        [self animateMessageLabelFadeOut];
        return;
    }
    // attempt to create new account
    NSString * errorMsg = [[AccountManager sharedInstance] createNewEmployeeWithPIN:_pinTxt.text firstName:_firstNameTxt.text lastName:_lastNameTxt.text email:_emailTxt.text];
    if(errorMsg!=nil) {
        // account already exists, display custom error message
        _messageLabel.text = errorMsg;
        [self animateMessageLabelFadeOut];
    } else {
        // success, pop view off nav stack
        _pinTxt.text = @"";
        _firstNameTxt.text = @"";
        _lastNameTxt.text = @"";
        _emailTxt.text = @"";
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)animateMessageLabelFadeOut {
    // animate fade-out of error message
    _messageLabel.alpha = 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _messageLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.0f animations:^{
            _messageLabel.alpha = 0.0f;
        } completion:nil];
    }];
}

#
#pragma mark - UITextFieldDelegate
#
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField.tag==kPINTextFieldTag) {
        // verify PIN contains only digits
        NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSRange numberRange = [string rangeOfCharacterFromSet: nonNumbers];

        // limit PIN entry to maximum of 4 characters
        if(range.length + range.location > textField.text.length) {
            return (numberRange.location == NSNotFound); // prevent 'undo' bug
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength <= 4 && numberRange.location == NSNotFound);
    }
    return true;
}


@end

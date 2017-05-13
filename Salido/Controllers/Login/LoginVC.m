//
//  LoginVC.m
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "LoginVC.h"
#import "AccountManager.h"
#import "SearchVC.h"
#import "SWRevealViewController.h"
#import "ShoppingCartManager.h"

@interface LoginVC ()
@property (nonatomic, strong) AccountManager * accountManager;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _messageLabel.alpha = 0.0f;

}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _pinLabel.text = @"";
}

-(IBAction)numberPadEntry:(UIButton *)sender {
    _pinLabel.text = [_pinLabel.text stringByAppendingString:sender.titleLabel.text];
    
    // once 4 characters have been entered, search for matching employee record
    if(_pinLabel.text.length >= 4) {
        Employee * emp = [[AccountManager sharedInstance] employeeWithPIN:_pinLabel.text];
        if(emp!=nil) {
            // match found, create session
            _messageLabel.text = @"Login Successfull";
            _messageLabel.textColor = [UIColor greenColor];
            [self animateLoginMessage:true completion:^void (BOOL finished) {
                
                // init new, empty shopping cart for session
                [[ShoppingCartManager sharedInstance] emptyCart];
                
                // proceed to product-search view controller
                UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SWRevealViewController * revealViewController = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"revealVC"];
                [self.navigationController pushViewController:revealViewController animated:true];
            }];
        } else {
            // no match found, notify user
            _messageLabel.text = @"Invalid PIN";
            _messageLabel.textColor = [UIColor redColor];
            [self animateLoginMessage:false completion:nil];
        }
    }
}
-(IBAction)numberPadClearBtnTapped:(UIButton *)sender {
    _pinLabel.text = @"";
}
-(IBAction)createAccountBtnTapped:(id)sender {
    [self performSegueWithIdentifier:@"createAccount" sender:sender];
}
-(IBAction)lookupPINBtnTapped:(id)sender {
    [self performSegueWithIdentifier:@"lookupPIN" sender:sender];
}

-(void)animateLoginMessage:(BOOL)success completion:(void (^)(BOOL finished))completionBlock{
    _messageLabel.alpha = 0.0f;
    float fadeOutDuration = 0.5f;
    if(!success)
        fadeOutDuration = 2.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _messageLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        _pinLabel.text = @"";
        [UIView animateWithDuration:fadeOutDuration animations:^{
            _messageLabel.alpha = 0.0f;
        } completion:completionBlock];
    }];
}


@end

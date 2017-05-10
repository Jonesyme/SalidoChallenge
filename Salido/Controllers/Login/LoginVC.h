//
//  LoginVC.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *messageLabel; // for notifying user of failed login
@property (nonatomic, weak) IBOutlet UILabel *pinLabel;     // to display PIN during entry

-(IBAction)numberPadEntry:(UIButton *)sender;               // action for all numeric buttons
-(IBAction)numberPadClearBtnTapped:(UIButton *)sender;      // action for 'clear' button
-(IBAction)createAccountBtnTapped:(id)sender;               // action for 'create new account' button
-(IBAction)lookupPINBtnTapped:(id)sender;                   // action for 'I forgot my PIN' button

/**
 Animate a login message fade in/out to user
 @param success true is login was a success, false if login failed
 @param completionBlock called once both animations have finished
 @note will clear pinLabel text after initial fade-in animation
 */
-(void)animateLoginMessage:(BOOL)success completion:(void (^)(BOOL finished))completionBlock;

@end

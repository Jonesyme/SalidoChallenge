//
//  EmployeeTableViewCell.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "EmployeeTableViewCell.h"


@interface EmployeeTableViewCell ()

@end

@implementation EmployeeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)configureCellContent {
    _pinLbl.text = _employee.pin;
    _firstNameLbl.text = _employee.firstName;
    _lastNameLbl.text = _employee.lastName;
    _emailLbl.text = _employee.email;
    _startDateLbl.text = [_employee formattedStartDateString];
    _cartLbl.text = @"..."; //TODO: make this work with shopping cart data
}
-(IBAction)deleteUserAccount:(id)sender {
    // delete this user
    if(_delegate!=nil)
       [_delegate deleteEmployeeRecordWithPIN:_employee.pin];
}

@end

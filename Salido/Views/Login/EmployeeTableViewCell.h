//
//  EmployeeTableViewCell.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeTableViewCellDeletionProtocol.h"
#import "Employee.h"

@class Employee;

/**
 Cell for search account/employee table
 */
@interface EmployeeTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *pinLbl;
@property (nonatomic, weak) IBOutlet UILabel *firstNameLbl;
@property (nonatomic, weak) IBOutlet UILabel *lastNameLbl;
@property (nonatomic, weak) IBOutlet UILabel *emailLbl;
@property (nonatomic, weak) IBOutlet UILabel *cartLbl;
@property (nonatomic, weak) IBOutlet UILabel *startDateLbl;
@property (nonatomic, weak) IBOutlet UIButton *deleteUserBtn;

@property (nonatomic, weak) Employee * employee; // data model class
@property (nonatomic, weak) id <EmployeeTableViewCellDeletionDelegate> delegate; // delegate to perform deletion of associated employee record
-(void)configureCellContent;
-(IBAction)deleteUserAccount:(id)sender;

@end

//
//  EmployeeTableViewCellDeletionProtocol.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//
@class EmployeeTableViewCell;

/**
 Delegate to facilitate callback from table cell back to tableview so it can reach the AccountManager and delete an account
 and also reload the table after the deletion...
 */
@protocol EmployeeTableViewCellDeletionDelegate <NSObject>

- (void)deleteEmployeeRecordWithPIN:(NSString *)pin;

@end

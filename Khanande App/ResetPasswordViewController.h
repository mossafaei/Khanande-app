//
//  ResetPasswordViewController.h
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UITextView *text;
    IBOutlet UITextField *codefield;
    IBOutlet UITextField *newpasswordfield;
    IBOutlet UITextField *newpasswordcomfield;
}

- (IBAction)changepass:(id)sender;

@end

//
//  LoginViewController.h
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController/SWRevealViewController.h>
#import "JSONKit.h"
@interface LoginViewController : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UIButton *forgot;
    IBOutlet UITextField *usernamefield;
    IBOutlet UITextField *passwordfield;
}

- (IBAction)login:(id)sender;
@end

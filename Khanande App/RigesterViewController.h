//
//  RigesterViewController.h
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigesterViewController : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UITextField *Emailfield;
    IBOutlet UITextField *usernamefield;
    IBOutlet UITextField *passwordfield;
    IBOutlet UITextField *passwordcomfield;
    IBOutlet UITextField *phonenum;
    
}
- (IBAction)rigester:(id)sender;

@end

//
//  CodeToEmailViewController.h
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeToEmailViewController : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UITextField *Emailfield;
}
- (IBAction)sendcode:(id)sender;

@end

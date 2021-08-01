//
//  InviteTableViewController.h
//  Khanande
//
//  Created by Apple on 7/5/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteTableViewCell.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <AFNetworking/AFNetworking.h>
@interface InviteTableViewController : UITableViewController <MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>{
    IBOutlet UIBarButtonItem *revealbutton;
    NSArray *menuitem;
    NSString *invitcode;
}

@end

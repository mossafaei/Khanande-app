//
//  InviteTableViewController.m
//  Khanande
//
//  Created by Apple on 7/5/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "InviteTableViewController.h"

@interface InviteTableViewController ()

@end

@implementation InviteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    invitcode = [[NSString alloc]init];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [revealbutton setTarget: self.revealViewController];
        [revealbutton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = background;
    
    menuitem = @[@"Describe",@"Facebook",@"Twitter",@"Telegram",@"SMS"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *email = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"Email"];
    //NSLog(@"%@",email);
    
    NSDictionary *parameters = @{@"email":email,@"username": @"khanandeappmostafa", @"password": @"Morteza09166414783" };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://mspdeveloper.ir/invitationCode.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        invitcode = response;
        //[self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return menuitem.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return  77;
    }else{
    return 44;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"Describe";
        
        InviteTableViewCell *cell = (InviteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[InviteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textview.font = [UIFont fontWithName:@"BYekan" size:20];
      //  cell.textview.text = [cell.textview.text stringByAppendingString:[NSString stringWithFormat:@"%@ کد شما:",invitcode]];
        
        return cell;
    }else{
    
    
        NSString *CellIdentifier = [menuitem objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
[tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:[NSString stringWithFormat:@"می دونم صدای قشنگی داری. اپلیکیشن خواننده رو از اپ استور دانلود کن و با کد دعوت:%@ وارد شو تا آهنگ های مورد علاقتو با صدای خودت باز خوانی کنی. ",invitcode]];
            [tweetSheet addURL:[NSURL URLWithString:@"https://appsto.re/us/MP8Abb.i"]];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
    }
    
    if (indexPath.row == 1) {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [controller setInitialText:[NSString stringWithFormat:@"می دونم صدای قشنگی داری. اپلیکیشن خواننده رو از اپ استور دانلود کن و با کد دعوت:%@ وارد شو تا آهنگ های مورد علاقتو با صدای خودت باز خوانی کنی. ",invitcode]];
            [controller addURL:[NSURL URLWithString:@"https://appsto.re/us/MP8Abb.i"]];
            [self presentViewController:controller animated:YES completion:Nil];
        }
    }
    
    if (indexPath.row == 3) {
        NSString *emailTitle = @"برنامه خواننده رو تا حالا دیدی؟؟!!";
        // Email Content
        NSString *messageBody = [NSString stringWithFormat:@"می دونم صدای قشنگی داری. اپلیکیشن خواننده رو از اپ استور دانلود کن و با کد دعوت:%@ وارد شو تا آهنگ های مورد علاقتو با صدای خودت باز خوانی کنی. لینک دانلود برنامه:https://appsto.re/us/MP8Abb.i",invitcode];
        // To address
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    
    if (indexPath.row == 4) {
        if(![MFMessageComposeViewController canSendText]) {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            return;
        }
        

        NSString *message = [NSString stringWithFormat:@"می دونم صدای قشنگی داری. اپلیکیشن خواننده رو از اپ استور دانلود کن و با کد دعوت:%@ وارد شو تا آهنگ های مورد علاقتو با صدای خودت باز خوانی کنی. لینک دانلود برنامه:https://appsto.re/us/MP8Abb.i",invitcode];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setBody:message];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

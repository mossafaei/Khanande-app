//
//  LeftMenuTableViewController.m
//  Khanande
//
//  Created by Apple on 7/4/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "LeftMenuTableViewController.h"

@interface LeftMenuTableViewController ()

@end

@implementation LeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"User",@"Home",@"SongReq",@"Invite",@"Channel",@"Instagram"];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = background;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 2) {
        alertsong = [[UIAlertView alloc] initWithTitle:@"Song Request(درخواست آهنگ جدید)" message:@"Please Write The Name of Your Requsted Song." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
        alertsong.tag = 200;
        alertsong.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertsong show];
    }
    
    if (indexPath.row == 4){
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://telegram.me/khanandeapp"]];
    }
    
    if (indexPath.row == 5){
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/khanandeapp/"]];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"User";
        
        MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Username"];
        
        NSString *coin = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Coin"];
        cell.usernamelabel.text = savedValue;
        cell.coinlabel.text = [NSString stringWithFormat:@"Coin: %@",coin];
        
        return cell;
    }else{
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return 201;
    }else{
        return 44;
    }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1 && alertView.tag == 200){
        NSString*str = [alertsong textFieldAtIndex:0].text;
        NSDictionary *parameters = @{@"username": @"khanandeappmostafa", @"password": @"Morteza09166414783" , @"song" : str};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:@"http://www.mspdeveloper.ir/app/songreq.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *str1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            if ([str1 isEqualToString:@"yes"]) {
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Thank You" message:@"Message successfully delivered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }else{
                
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Message not delivered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Message not delivered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
        
        
        
        
        
    }
    
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

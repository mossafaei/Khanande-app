//
//  BoughtTableViewController.m
//  Khanande
//
//  Created by Apple on 6/3/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "BoughtTableViewController.h"

@interface BoughtTableViewController ()

@end

@implementation BoughtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1];
   /// self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
  //  self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString *email = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Email"];
    NSDictionary *parameters = @{@"username": @"khanandeappmostafa", @"password": @"_______" , @"email" : email};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://mspdeveloper.ir/app/getPurchasedSongs-v2.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([response isEqualToString:@"noitem"]){
            UILabel *labelnoitem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            labelnoitem.text = @"No Item";
            labelnoitem.textAlignment = NSTextAlignmentCenter;
            labelnoitem.textColor = [UIColor whiteColor];
            [self.tableView addSubview:labelnoitem];
            make = 0;
            
        }else{
            myTag = [[NSMutableArray alloc]init];
            mySong = [[NSMutableArray alloc]init];
            myArtist = [[NSMutableArray alloc]init];
            myImage = [[NSMutableArray alloc]init];
            
            NSArray *dependalamt = [[NSArray alloc] init];
            dependalamt = [response componentsSeparatedByString:@"?"];
            for (int i =0; i < [dependalamt count]; i++) {
                NSArray *hashtagjoda = [[NSArray alloc]init];
                hashtagjoda = [dependalamt[i] componentsSeparatedByString:@"#"];
                
                [myTag addObject:hashtagjoda[0]];
                [myArtist addObject:hashtagjoda[1]];
                [mySong addObject:hashtagjoda[2]];
                [myImage addObject:[NSString stringWithFormat:@"http://mspdeveloper.ir/app/%@/%@.jpg",hashtagjoda[0],hashtagjoda[0]]];
                
            }
            make = [dependalamt count];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString *email = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Email"];
    NSDictionary *parameters = @{@"username": @"khanandeappmostafa", @"password": @"________" , @"email" : email};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://mspdeveloper.ir/app/getPurchasedSongs-v2.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([response isEqualToString:@"noitem"]){
            UILabel *labelnoitem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            labelnoitem.text = @"No Item";
            labelnoitem.textAlignment = NSTextAlignmentCenter;
            labelnoitem.textColor = [UIColor whiteColor];
            [self.tableView addSubview:labelnoitem];
            make = 0;
            
        }else{
            myTag = [[NSMutableArray alloc]init];
            mySong = [[NSMutableArray alloc]init];
            myArtist = [[NSMutableArray alloc]init];
            myImage = [[NSMutableArray alloc]init];
            
            NSArray *dependalamt = [[NSArray alloc] init];
            dependalamt = [response componentsSeparatedByString:@"?"];
            for (int i =0; i < [dependalamt count]; i++) {
                NSArray *hashtagjoda = [[NSArray alloc]init];
                hashtagjoda = [dependalamt[i] componentsSeparatedByString:@"#"];
                
                [myTag addObject:hashtagjoda[0]];
                [myArtist addObject:hashtagjoda[1]];
                [mySong addObject:hashtagjoda[2]];
                [myImage addObject:[NSString stringWithFormat:@"http://mspdeveloper.ir/app/%@/%@.jpg",hashtagjoda[0],hashtagjoda[0]]];
                
            }
            make = [dependalamt count];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (make*2)-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
     static NSString *simpleTableIdentifier = @"MusicItemTableViewCell";
    MusicItemTableViewCell *cell = (MusicItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MusicItemTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *strutl = [[NSString alloc]init];
    strutl = myImage[indexPath.row/2];
    [cell.imagecover sd_setImageWithURL:[NSURL URLWithString:strutl] placeholderImage:[UIImage imageNamed:@"play-button-black.png"]];
    cell.artistlabel.text = myArtist[indexPath.row/2];
    cell.songname.text = mySong[indexPath.row/2];

    cell.button.hidden = YES;
        cell.animateview.hidden = YES;
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"rectangle130.png"]];
        cell.backgroundColor = background;
    return cell;
    }else{
        
        static NSString *simpleTableIdentifier = @"BlackTableViewCell";
        
        BlackTableViewCell *cell = (BlackTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BlackTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        return cell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0)  {
    return 69;
    }else{
        return 3;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row % 2 == 0){
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[myTag[indexPath.row/2] intValue]] forKey:@"TAG"];
        TestViewController *viewController = [[TestViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

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

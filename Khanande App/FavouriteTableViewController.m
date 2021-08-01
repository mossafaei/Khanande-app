//
//  FavouriteTableViewController.m
//  Khanande App
//
//  Created by Apple on 9/12/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "FavouriteTableViewController.h"

@interface FavouriteTableViewController ()

@end

@implementation FavouriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Top Songs";
   // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:38 green:38 blue:38 alpha:1];
    //self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString*sendData = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mspdeveloper.ir/app/checklike.php?dl=1"]];
    
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    [request setHTTPBody:[sendData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPMethod:@"POST"];
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   NSString* answerchecklike = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",answerchecklike);
   
    
    myImage = [[NSMutableArray alloc ]init];
   // myLike = [[NSMutableArray alloc]init];
  //  myName = [[NSMutableArray alloc]init];
   myArray = [answerchecklike componentsSeparatedByString:@"##"];
   // NSLog(@"%@",myArray[0]);
    for (NSUInteger i=0; i<=[myArray count]-1; i++) {
        NSUInteger myInt = [myArray[i] intValue];
        [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",myInt+1,myInt+1]];
     //   [myLike addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-like.txt",myInt+1,myInt+1]];
       // [myName addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.txt?dl=1",myInt+1,myInt+1]];
    }
    if ([myImage count] % 2 == 0 ) {
        make = [myImage count]/2;
    }else{
        make = ([myImage count]/2)+1;
    }
    if (![self connected]) {
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Internet connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alet show];
        [refreshControl endRefreshing];
    }else{
    
    [self.tableView reloadData];
        
    }
}


- (void)refreshTable {
     [refreshControl endRefreshing];
    countsection = 0;
    [myImage removeAllObjects];
    [myLike removeAllObjects];
    [myName removeAllObjects];
    
    
    NSString*sendData = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mspdeveloper.ir/app/checklike.php"]];
    
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    [request setHTTPBody:[sendData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPMethod:@"POST"];
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString* answerchecklike = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",answerchecklike);
    
    
    myImage = [[NSMutableArray alloc ]init];
  //  myLike = [[NSMutableArray alloc]init];
   // myName = [[NSMutableArray alloc]init];
    myArray = [answerchecklike componentsSeparatedByString:@"##"];
    // NSLog(@"%@",myArray[0]);
    for (NSUInteger i=0; i<=[myArray count]-1; i++) {
        NSUInteger myInt = [myArray[i] intValue];
       // int b = arc4random() % 1000000;
        [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",myInt+1,myInt+1]];
     //   [myLike addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-like.txt",myInt+1,myInt+1]];
       // [myName addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.txt?dl=1",myInt+1,myInt+1]];
    }
    if ([myImage count] % 2 == 0 ) {
        make = [myImage count]/2;
    }else{
        make = ([myImage count]/2)+1;
    }
    
    if (![self connected]) {
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Internet connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alet show];
        
        [refreshControl endRefreshing];
        
    }else{
    [self.tableView reloadData];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
   // [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    countsection +=1;
    
    NSString*urlstirng1 = myImage[indexPath.row*2];

    

    [cell.imagecell1 sd_setImageWithURL:[NSURL URLWithString:urlstirng1]];
    cell.buttoncell1.tag =[myImage count] - indexPath.row*2;
    [cell.buttoncell1 addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    countsection +=1;
    
    if( countsection-1 != [myImage count]){
        NSString*urlstirng2 = myImage[indexPath.row*2+1];
     


        
        [cell.imagecell2 sd_setImageWithURL:[NSURL URLWithString:urlstirng2]];
        cell.buttoncell2.tag = [myImage count] - (indexPath.row*2+1);
        [cell.buttoncell2 addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else{
        cell.buttoncell2.hidden = true;
    }
    
    
    
    return cell;
    
}
-(void)yourButtonClicked:(UIButton*)sender{
    
    NSLog(@"%zd",sender.tag);
    NSUInteger myInt = [myImage count] - sender.tag;
    myInt = [myArray[myInt] intValue];
    myInt +=1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:myInt] forKey:@"TAG"];
    TestViewController *viewController = [[TestViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //[refreshControl endRefreshing];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.view.frame.size.width/2;
    
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


-(IBAction)addsong:(id)sender{
    alertsong = [[UIAlertView alloc] initWithTitle:@"Song Request" message:@"Please Write The Name of Your Requsted Song." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    alertsong.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertsong show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
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

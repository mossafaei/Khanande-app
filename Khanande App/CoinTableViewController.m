//
//  CoinTableViewController.m
//  Khanande
//
//  Created by Apple on 6/7/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "CoinTableViewController.h"

@interface CoinTableViewController ()

@end

@implementation CoinTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",self.view.frame.size.width/3);
    baar = false;
    count = -1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    self.tableView.backgroundColor =[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    myImage = [[NSMutableArray alloc]init];
    for (int i=1; i<=6; i++) {
        NSString *str = [[NSString alloc]init];
        str = [NSString stringWithFormat:@"%zd.jpg",i];
        [myImage addObject:str];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((self.view.frame.size.width/3)*100)/45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"CoinTableViewCell";
    
    CoinTableViewCell *cell = (CoinTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CoinTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //[cell.bu1 setTitle:@"" forState:UIControlStateNormal];
    //[cell.bu2 setTitle:@"" forState:UIControlStateNormal];
    //[cell.bu3 setTitle:@"" forState:UIControlStateNormal];

            
    CGRect rect1;
    rect1.origin.x = 0;
    rect1.origin.y = 0;
    rect1.size.width = self.view.frame.size.width/3;
    rect1.size.height = ((self.view.frame.size.width/3)*100)/45;
    //img1.frame = rect1;
    UIImageView*img1 = [[UIImageView alloc]initWithFrame:rect1];
    UIButton *but1 = [[UIButton alloc]initWithFrame:rect1];
    [cell addSubview:img1];
    [cell addSubview:but1];
   // cell.bu1.frame = rect1;
   // cell.im1.frame = rect1;
    
    CGRect rect2;
    rect2.origin.x =self.view.frame.size.width/3;
    rect2.origin.y = 0;
    rect2.size.width =self.view.frame.size.width/3;
    rect2.size.height = ((self.view.frame.size.width/3)*100)/45;
    UIImageView*img2 = [[UIImageView alloc]initWithFrame:rect2];
    UIButton *but2 = [[UIButton alloc]initWithFrame:rect2];
    [cell addSubview:img2];
    [cell addSubview:but2];
   // cell.bu2.frame = rect2;
   // cell.im2.frame = rect2;
    
    CGRect rect3;
    rect3.origin.x =self.view.frame.size.width/3*2;
    rect3.origin.y = 0;
    rect3.size.width =self.view.frame.size.width/3;
    rect3.size.height=((self.view.frame.size.width/3)*100)/45;
    UIImageView*img3 = [[UIImageView alloc]initWithFrame:rect3];
    UIButton *but3 = [[UIButton alloc]initWithFrame:rect3];
    [cell addSubview:img3];
    [cell addSubview:but3];
   // cell.bu3.frame = rect3;
   // cell.im3.frame=rect3;

    
    if (count == 5) {
        count =-1;
    }
    
    count +=1;
    [img1 setImage:[UIImage imageNamed:myImage[count]]];
    //[cell.im1 setImage:[UIImage imageNamed:myImage[count]]];
   // [cell.bu1 setBackgroundImage:[UIImage imageNamed:myImage[count]] forState:UIControlStateNormal];
    but1.tag = count;
    [but1 addTarget:self action:@selector(clickedcell:) forControlEvents:UIControlEventTouchUpInside];
    
    if (count == 5) {
        count =-1;
    }
   
    count +=1;
      [img2 setImage:[UIImage imageNamed:myImage[count]]];
   // [cell.im2 setImage:[UIImage imageNamed:myImage[count]]];
    //[cell.bu2 setBackgroundImage:[UIImage imageNamed:myImage[count]] forState:UIControlStateNormal];
   // cell.bu2.tag = count;
   // [cell.bu2 addTarget:self action:@selector(clickedcell:) forControlEvents:UIControlEventTouchUpInside];
    but2.tag = count;
    [but2 addTarget:self action:@selector(clickedcell:) forControlEvents:UIControlEventTouchUpInside];
    
    if (count == 5) {
        count =-1;
    }
    
    count +=1;
      [img3 setImage:[UIImage imageNamed:myImage[count]]];
    //[cell.im3 setImage:[UIImage imageNamed:myImage[count]]];
    //[cell.bu3 setBackgroundImage:[UIImage imageNamed:myImage[count]] forState:UIControlStateNormal];
   // cell.bu3.tag = count;
    //[cell.bu3 addTarget:self action:@selector(clickedcell:) forControlEvents:UIControlEventTouchUpInside];
    but3.tag = count;
    [but3 addTarget:self action:@selector(clickedcell:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
    
}

-(void)clickedcell:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self coin200];
            break;
        case 1:
            [self coin500];
            break;
        case 2:
            [self coin1250];
            break;
        case 3:
            [self coin2650];
            break;
        case 4:
            [self coin5750];
            break;
        case 5:
            [self coin12100];
            break;
            
        default:
            break;
    }
    
}



-(void)coin200{
   // NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *udid = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"Email"];
    NSString *post = @"sku=hp_574fe7e13c3d2464603691&device_id=";
    post = [post stringByAppendingString:udid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/pay-request"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString*str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data1
                                                                 options:kNilOptions
                                                                   error:nil];
    [[NSUserDefaults standardUserDefaults] setObject: [jsonResponse objectForKey:@"pay_code"] forKey:@"PAY_COD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject: @"200" forKey:@"COIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PaymentViewController *viewController = [[PaymentViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)coin500{
    
    NSString *udid = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"Email"];
    NSString *post = @"sku=hp_574fed0384ffa714478620&device_id=";
    post = [post stringByAppendingString:udid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/pay-request"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString*str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data1
                                                                 options:kNilOptions
                                                                   error:nil];
    [[NSUserDefaults standardUserDefaults] setObject: [jsonResponse objectForKey:@"pay_code"] forKey:@"PAY_COD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject: @"500" forKey:@"COIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PaymentViewController *viewController = [[PaymentViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)coin1250{
    NSString *udid = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"Email"];
    NSString *post = @"sku=hp_574fe8e645576830059383&device_id=";
    post = [post stringByAppendingString:udid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/pay-request"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString*str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data1
                                                                 options:kNilOptions
                                                                   error:nil];
    [[NSUserDefaults standardUserDefaults] setObject: [jsonResponse objectForKey:@"pay_code"] forKey:@"PAY_COD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject: @"1250" forKey:@"COIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PaymentViewController *viewController = [[PaymentViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)coin2650{
    NSString *udid = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"Email"];
    NSString *post = @"sku=hp_574fe9bc20dec357951696&device_id=";
    post = [post stringByAppendingString:udid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/pay-request"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString*str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data1
                                                                 options:kNilOptions
                                                                   error:nil];
    [[NSUserDefaults standardUserDefaults] setObject: [jsonResponse objectForKey:@"pay_code"] forKey:@"PAY_COD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSUserDefaults standardUserDefaults] setObject: @"2650" forKey:@"COIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PaymentViewController *viewController = [[PaymentViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}


-(void)coin5750{
    NSString *udid = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"Email"];
    NSString *post = @"sku=hp_574fea61c6813007556755&device_id=";
    post = [post stringByAppendingString:udid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/pay-request"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString*str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data1
                                                                 options:kNilOptions
                                                                   error:nil];
    [[NSUserDefaults standardUserDefaults] setObject: [jsonResponse objectForKey:@"pay_code"] forKey:@"PAY_COD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject: @"5750" forKey:@"COIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PaymentViewController *viewController = [[PaymentViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)coin12100{
    NSString *udid = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"Email"];
    NSString *post = @"sku=hp_574ff5bcda563896688722&device_id=";
    post = [post stringByAppendingString:udid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/pay-request"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString*str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data1
                                                                 options:kNilOptions
                                                                   error:nil];
    [[NSUserDefaults standardUserDefaults] setObject: [jsonResponse objectForKey:@"pay_code"] forKey:@"PAY_COD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject: @"12100" forKey:@"COIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PaymentViewController *viewController = [[PaymentViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end

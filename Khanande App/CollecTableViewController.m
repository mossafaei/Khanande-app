//
//  CollecTableViewController.m
//  Khanande
//
//  Created by Apple on 5/29/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "CollecTableViewController.h"

@interface CollecTableViewController ()

@end

@implementation CollecTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = -1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    self.tableView.backgroundColor =[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    self.title = @"Collection";
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"COLLECT_TAG"] integerValue];
    NSURL*url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/collection/%zd.php",tag]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    myImage = [[NSMutableArray alloc]init];
    array= [[NSArray alloc]init];
    array = [str componentsSeparatedByString:@"#"];
    for (int i=0;i<[array count]; i++) {
        [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%@/%@.jpg",array[i],array[i]]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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
    return [array count]/2;
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
    
    
    count +=1;
    [cell.imagecell1 sd_setImageWithURL:[NSURL URLWithString:myImage[count]]];
    cell.buttoncell1.tag = [array[count] integerValue];
    [cell.buttoncell1 addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    count +=1;
    [cell.imagecell2 sd_setImageWithURL:[NSURL URLWithString:myImage[count]]];
    cell.buttoncell2.tag = [array[count] integerValue];
    [cell.buttoncell2 addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.view.frame.size.width/2;
    
}


-(void)yourButtonClicked:(UIButton*)sender{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:sender.tag] forKey:@"TAG"];
    TestViewController *viewController = [[TestViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
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

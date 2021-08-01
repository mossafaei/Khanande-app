//
//  CollectionTableViewController.m
//  Khanande
//
//  Created by Apple on 5/29/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    myImage = [[NSMutableArray alloc]init];
    myTag = [[NSMutableArray alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSURL*url = [NSURL URLWithString:@"http://www.mspdeveloper.ir/app/collection/collec.txt"];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    array = [[NSArray alloc]init];
    array = [str componentsSeparatedByString:@"?"];
    myCoverimage = [[NSMutableArray alloc]init];
    for (int i=0;i<[array count];i++){
        NSArray *array2 = [[NSArray alloc]init];
        array2 = [array[i] componentsSeparatedByString:@"#"];
        if ([array2[1] isEqualToString:@"collec"]) {
            count +=1;
            [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/collection/%@.jpg",array2[0]]];
            [myTag addObject:array2[0]];
        }
        [myCoverimage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/collection/%@.jpg",array2[0]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
   // self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
      static NSString *simpleTableIdentifier = @"CollTableViewCell";
     
     CollTableViewCell *cell = (CollTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     if (cell == nil)
     {
     NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CollTableViewCell" owner:self options:nil];
     cell = [nib objectAtIndex:0];
     }
    [cell.imageviewcell sd_setImageWithURL:[NSURL URLWithString:myImage[indexPath.row]]];
     
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.view.frame.size.width*0.4;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[myTag[indexPath.row] intValue]] forKey:@"COLLECT_TAG"];
    CollecTableViewController *viewcontro = [[CollecTableViewController alloc]init];
    [self.navigationController pushViewController:viewcontro animated:YES];
    
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

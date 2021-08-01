//
//  ResetPasswordViewController.m
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    text.font = [UIFont fontWithName:@"BYekan" size:24];
    codefield.delegate = self;
    newpasswordcomfield.delegate = self;
    newpasswordfield.delegate = self;
    // Do any additional setup after loading the view.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [codefield resignFirstResponder];
    [newpasswordfield resignFirstResponder];
    [newpasswordcomfield resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changepass:(id)sender {
    if ([codefield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"کد به طور کامل وارد نشده است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else if ([newpasswordfield.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"رمز عبور به طور کامل وارد نشده است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else{
        if (newpasswordfield.text == newpasswordcomfield.text) {
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"EMAIL"];
    NSDictionary *j2 = @{@"email":savedValue,@"code":codefield.text,@"password":newpasswordfield.text};
    NSDictionary *j1 = @{@"operation" : @"resPass" , @"user":j2};
    
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:j1 options:NSJSONWritingPrettyPrinted error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://www.mspdeveloper.ir/index.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsondata];
    
    
    NSURLResponse *response = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString: %@",responseString);
    
    
    NSDictionary *resdict = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
    NSLog(@"%@",[resdict objectForKey:@"result"]);
    if ([[resdict objectForKey:@"result"] isEqualToString:@"failure"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"نام کاربری یا رمز عبور شما اشتباه است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else{
        NSLog(@"Password Changed");
        [self performSegueWithIdentifier:@"changepasssegue" sender:sender];
    }
        }else{
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"رمز عبور ها با یکدیگر برابر نیستند." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
            [alert show];
        }
   }
}
@end

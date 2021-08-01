//
//  RigesterViewController.m
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "RigesterViewController.h"

@interface RigesterViewController ()

@end

@implementation RigesterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Emailfield.delegate = self;
    usernamefield.delegate=self;
    passwordfield.delegate = self;
    passwordcomfield.delegate = self;
    phonenum.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [Emailfield resignFirstResponder];
    [usernamefield resignFirstResponder];
    [passwordfield resignFirstResponder];
    [passwordcomfield resignFirstResponder];
    [phonenum resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)rigester:(id)sender {
    if ([Emailfield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"ایمیل به طور کامل وارد نشده است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else if ([usernamefield.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"نام کاربری به طور کامل وارد نشده است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else if ([passwordfield.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"رمز عبور به طور کامل وارد نشده است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else{
        
    if ([self validateEmail:Emailfield.text]) {
        
        if ([passwordfield.text isEqualToString:passwordcomfield.text]) {
            if (phonenum.text == nil || [phonenum.text length] == 0) {
                phonenum.text = @"0";
            }
            
            NSDictionary *j2 = @{@"name":usernamefield.text , @"email":Emailfield.text,@"password":passwordfield.text , @"phoneNumber":phonenum.text};
            NSDictionary *j1 = @{@"operation" : @"register" , @"user":j2};
            
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
            
            if ([[resdict objectForKey:@"result"] isEqualToString:@"failure"]) {
                
                if ([[resdict objectForKey:@"message"] isEqualToString:@"emailError"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"خطا" message:@"این ایمیل قبلا ثبت شده است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
                    [alert show];
                }else if ([[resdict objectForKey:@"message"] isEqualToString:@"usernameError"]){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"خطا" message:@"این نام کاربری قبلا انتخاب شده است. لطفا یک نام کاربری دیگری بنویسید." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
                    [alert show];
                }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"خطا" message:@"ثبت نام نا موفق بود." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
                [alert show];
                }
            }else{
                NSLog(@"Signup");
                [self performSegueWithIdentifier:@"signupsegue" sender:sender];
            }
            
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"خطا" message:@"رمز عبور های وارد شده با یکدیگر برابر نیستند." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
            [alert show];
        }
        
        
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"خطا" message:@"ایمیل وارد شده اشتباه است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }
    }
}
@end

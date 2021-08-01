//
//  LoginViewController.m
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    forgot.titleLabel.font = [UIFont fontWithName:@"BYekan" size:20];
    usernamefield.delegate = self;
    passwordfield.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [usernamefield resignFirstResponder];
    [passwordfield resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)loginback:(UIStoryboardSegue *)segue {
    // reset UI elements etc here
}

- (IBAction)login:(id)sender {
    NSString *token = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"TOKEN"];
    if ((token == nil) || ([token length] == 0)) {
        token = @"1";
    }
    NSDictionary *j2 = @{@"email":usernamefield.text,@"password":passwordfield.text,@"token":token};
    NSDictionary *j1 = @{@"operation" : @"login" , @"user":j2};
    
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
    
          JSONDecoder *decoder = [[JSONDecoder alloc] init];
    
    NSDictionary *resdict = [decoder objectWithData:returnData]; //[NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
    NSLog(@"%@",[resdict objectForKey:@"result"]);
    if ([[resdict objectForKey:@"result"] isEqualToString:@"failure"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"نام کاربری یا رمز عبور شما اشتباه است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else{
        NSLog(@"Login");
        
        NSDictionary *userdict = [resdict objectForKey:@"user"];
        
        NSString *valueToSave = [userdict objectForKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"Username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSString *email = [userdict objectForKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"Email"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self performSegueWithIdentifier:@"loginsegue" sender:sender];
        int bm = 1;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:bm] forKey:@"DIDaval"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"توجه" message:@"اگر در ورژن های قبلی اپلیکیشن خواننده برای خرید سکه و یا آهنگ پرداختی نموده اید و به اعتبار شما به صورت خودکار اضافه نشده است با ایمیل developermsp@gmail.com و یا ادمین کانال تلگرام تماس بگیرید تا اعتبار شما تصحیح شود." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
        
    }
    
    
}
@end

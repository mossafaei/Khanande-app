//
//  CodeToEmailViewController.m
//  Khanande
//
//  Created by Apple on 7/2/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "CodeToEmailViewController.h"

@interface CodeToEmailViewController ()

@end

@implementation CodeToEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Emailfield.delegate= self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [Emailfield resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (IBAction)sendcode:(id)sender {
    if ([self validateEmail:Emailfield.text]) {
    NSDictionary *j2 = @{@"email":Emailfield.text};
    NSDictionary *j1 = @{@"operation" : @"resPassReq" , @"user":j2};
    
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"عملیات ناموفق بود." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];
    }else{
        NSLog(@"Code Sended");
        NSString *valueToSave = Emailfield.text;
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"EMAIL"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"codesendsegue" sender:sender];
    }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"" delegate:self cancelButtonTitle:@"ایمیل وارد شده معتبر نیست." otherButtonTitles: nil];
        [alert show];
    }

}
@end

//
//  PaymentViewController.m
//  Khanande App
//
//  Created by Apple on 4/15/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"PAY_COD"];
    NSString*urlstr = [NSString stringWithFormat:@"https://hamrahpay.com/cart/app/pay/%@",savedValue];
         self.title = @"پرداخت";
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    web.delegate = self;
    [self.view addSubview:web];
    NSLog(@"%@",urlstr);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [web loadRequest:requestObj];
    
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
  //  alert = [[UIAlertView alloc]initWithTitle:@"لطفا صبر کنید..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    //[alert show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
   // [alert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"PAY_COD"];
    NSString *post = @"pay_code=";
    post = [post stringByAppendingString:savedValue];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://hamrahpay.com/rest-api/verify-payment"]];
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
    if ( [[jsonResponse objectForKey:@"status"] isEqualToString:@"SUCCESSFUL_PAYMENT"] ) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"پرداخت" message:@"پرداخت با موفقیت انجام شد." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        
        NSString *sendData = @"username=khanandeappmostafa";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        sendData = [sendData stringByAppendingString:@"&password=Morteza09166414783"];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        NSString *email = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Email"];
        
        sendData = [sendData stringByAppendingString:@"&email="];
        sendData = [sendData stringByAppendingString:email];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"COIN"];
        
        sendData = [sendData stringByAppendingString:@"&addCoin="];
        sendData = [sendData stringByAppendingString:savedValue];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mspdeveloper.ir/app/addCoin-v2.php"]];
        
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        [request setHTTPBody:[sendData dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPMethod:@"POST"];
        NSError *error = nil;
        NSURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString* answe = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",answe);
        if ([answe isEqualToString:@"yes"]) {
            NSLog(@"success");
        }else{
            //[self faildserver];
        }

        
        
        [alert show];
        
        
        
        
    }else{
        
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"پرداخت" message:@"پرداخت ناموفق بود." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
        [alert show];

        
        
    }
    
    
}

@end

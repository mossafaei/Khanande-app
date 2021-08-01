//
//  TestViewController.m
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController (){
    NSArray*_products;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nobat = 0;
    
    play = false;
    
}


-(void)viewDidDisappear:(BOOL)animated{
    imagecover = nil;
    image = nil;
    like =nil;
    micro =nil;
    playstop = nil;
    alertpurch = nil;
    likelabel = nil;
    singlabel = nil;
    timer1 = nil;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [imagecover removeFromSuperview];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 //   activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
  //  activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2-100/2, self.view.frame.size.height/2-100/2, 100.0f, 100.0f);
   // [self.view addSubview:activityIndicatorView];
    //[activityIndicatorView startAnimating];
        counter =0;
 NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    
    [alert show];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    imagecover = [[UIImageView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 60, self.view.frame.size.width*2, self.view.frame.size.width*2)];
    imagecover.alpha = 0.3;
    [self.view addSubview:imagecover];

    [imagecover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",tag,tag]]];


    image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:image];
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",tag,tag]]];
    
    like = [[UIButton alloc] init];
    CGRect rect = like.frame;
    rect.size.width = (self.view.frame.size.height-60-self.view.frame.size.width-30)/2;
    rect.size.height = rect.size.width;
    rect.origin.x = rect.size.width/2;
    rect.origin.y = 60+self.view.frame.size.width+5+rect.size.width/2;
    like.frame = rect;

    [like addTarget:self action:@selector(likeclicked) forControlEvents:UIControlEventTouchUpInside];
  //  like.hidden = YES;
    [self.view addSubview:like];
    
    
    micro = [[UIButton alloc] init];
    CGRect rect1 = micro.frame;
    rect1.size.width = (self.view.frame.size.height-60-self.view.frame.size.width-30)/2;
    rect1.size.height = rect1.size.width;
    rect1.origin.x = self.view.frame.size.width-rect1.size.width-rect1.size.width/2;
    rect1.origin.y = 60+self.view.frame.size.width+10+rect1.size.width/2;
    micro.frame = rect1;
    [micro setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
    [micro addTarget:self action:@selector(microclicked) forControlEvents:UIControlEventTouchUpInside];
    micro.hidden = YES;
    [self.view addSubview:micro];
    
    if (self.view.frame.size.width != 320){
        singlabel = [[UILabel alloc] initWithFrame:CGRectMake(micro.frame.origin.x+(micro.frame.size.width/4), micro.frame.origin.y+micro.frame.size.height, micro.frame.size.width, 30)];
    }else{
        singlabel = [[UILabel alloc] initWithFrame:CGRectMake(micro.frame.origin.x, micro.frame.origin.y+micro.frame.size.height, micro.frame.size.width, 30)];
        
    }
    singlabel.text = @"Sing!";
    singlabel.textColor = [UIColor whiteColor];
    [singlabel sizeToFit];
    singlabel.textAlignment = NSTextAlignmentCenter;
    singlabel.hidden = YES;
    [self.view addSubview:singlabel];
    
    
    buy = [[UIButton alloc] init];
    CGRect rect10 = micro.frame;
    rect10.size.width = (self.view.frame.size.height-60-self.view.frame.size.width-30)/2;
    rect10.size.height = rect10.size.width;
    rect10.origin.x = self.view.frame.size.width-rect10.size.width-rect10.size.width/2;
    rect10.origin.y = 60+self.view.frame.size.width+10+rect10.size.width/2;
    buy.frame = rect10;
    [buy setImage:[UIImage imageNamed:@"purchased-2.png"] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buyclicked) forControlEvents:UIControlEventTouchUpInside];
    buy.hidden = YES;
    [self.view addSubview:buy];
    

    
    
    
    likelabel = [[UILabel alloc] initWithFrame:CGRectMake(like.frame.origin.x , like.frame.origin.y+like.frame.size.height, like.frame.size.width, 30)];
    //NSString*likes = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-like.txt",tag,tag]] encoding:NSUTF8StringEncoding error:nil];
    likelabel.textColor = [UIColor whiteColor];
    likelabel.textAlignment = NSTextAlignmentCenter;
    //likelabel.hidden = YES;
    [self.view addSubview:likelabel];

    
    playstop = [[UIButton alloc] init];
    CGRect rect2 = playstop.frame;
    rect2.size.width = self.view.frame.size.width/2;
    rect2.size.height = rect2.size.width;
    rect2.origin.x = self.view.frame.size.width/2-rect2.size.width/2;
    rect2.origin.y = rect2.origin.x+60;
    playstop.frame = rect2;
    [playstop setImage:[UIImage imageNamed:@"play-button-black.png"] forState:UIControlStateNormal];
    [playstop addTarget:self action:@selector(playstopclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playstop];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    
    
    NSString *email = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Email"];
    NSDictionary *parameters2 = @{@"tag": [NSString stringWithFormat:@"%zd",tag], @"email": email};
    
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager2 GET:@"http://mspdeveloper.ir/app/sendsongdetailjson.php" parameters:parameters2 progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        JSONDecoder* decoder = [[JSONDecoder alloc] init];
        NSDictionary *jsondict = [decoder objectWithData:responseObject];
        
        nameofsong = [jsondict objectForKey:@"name"];
        likeofsong = [jsondict objectForKey:@"like"];
        priceofsong = [jsondict objectForKey:@"price"];
        boughtofsong = [jsondict objectForKey:@"bought"];
        didlikeofsong = [jsondict objectForKey:@"didlike"];
        
        
        if ([didlikeofsong isEqualToString:@"notliked"]) {
            [like setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
            buttonlikecolor = @"like.png";
        }else if ([didlikeofsong isEqualToString:@"liked"]){
            [like setImage:[UIImage imageNamed:@"like-red.png"] forState:UIControlStateNormal];
            buttonlikecolor = @"like-red.png";
        }
        
            self.title = nameofsong;
        
        
        
        if (self.view.frame.size.width != 320){
            buylabel = [[UILabel alloc] initWithFrame:CGRectMake(buy.frame.origin.x+(buy.frame.size.width/4), buy.frame.origin.y+buy.frame.size.height, buy.frame.size.width, 30)];
        }else{
            buylabel = [[UILabel alloc] initWithFrame:CGRectMake(micro.frame.origin.x, micro.frame.origin.y+micro.frame.size.height, micro.frame.size.width, 30)];
            
        }

        buylabel.text = [NSString stringWithFormat:@"%@",priceofsong];
        buylabel.textColor = [UIColor whiteColor];
        [buylabel sizeToFit];
        buylabel.textAlignment = NSTextAlignmentCenter;
        buylabel.hidden = YES;
        [self.view addSubview:buylabel];
        
        
        if ([boughtofsong isEqualToString:@"no"]) {
            buy.hidden = NO;
            buylabel.hidden = NO;
            micro.hidden = YES;
            singlabel.hidden = YES;
        }else if ([boughtofsong isEqualToString:@"yes"]){
            buy.hidden = YES;
            buylabel.hidden = YES;
            micro.hidden = NO;
            singlabel.hidden = NO;
        }
        
         likelabel.text = [NSString stringWithFormat:@"%@",likeofsong];
        
      //  [activityIndicatorView stopAnimating];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

 
//    [activityIndicatorView startAnimating];
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSString* resourcePath = [NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-5sec.mp3",tag,tag];
    
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    
    player = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    player.delegate = self;
    player.numberOfLoops = 0;
    
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}


-(void)likeclicked{
    
    if([buttonlikecolor isEqualToString:@"like.png"]){
        
       // NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];

        
        NSString *email = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Email"];
        
        NSDictionary *parameters = @{@"songID":[NSString stringWithFormat:@"%zd",tag],@"username": @"khanandeappmostafa", @"password": @"Morteza09166414783" , @"email" : email};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/like-song-v2.php"] parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            answerliked = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            [like setImage:[UIImage imageNamed:@"like-red.png"] forState:UIControlStateNormal];
            buttonlikecolor = @"like-red.png";
           // NSString*likes = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-like.txt",tag,tag]] encoding:NSUTF8StringEncoding error:nil];
            
            likelabel.text = answerliked;
  
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
       

        
    }else if ([buttonlikecolor isEqualToString:@"like-red.png"]){
        
       // NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
        
        
        NSString *email = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Email"];
        
        NSDictionary *parameters = @{@"songID":[NSString stringWithFormat:@"%zd",tag],@"username": @"khanandeappmostafa", @"password": @"Morteza09166414783" , @"email" : email};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/dislike-v2.php"] parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
           NSString* answerdisliked = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",answerdisliked);
            [like setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
            buttonlikecolor = @"like.png";
           // NSString*likes = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-like.txt?dl=1",tag,tag]] encoding:NSUTF8StringEncoding error:nil];
            
            likelabel.text = answerdisliked;
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
        
        
    }

}

-(void)buyclicked{
   //  NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *email = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Email"];
    NSURL*url10 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/getCredit-v2.php?email=%@",email]];
    NSString *money = [NSString stringWithContentsOfURL:url10 encoding:NSUTF8StringEncoding error:nil];
    if([money integerValue] >= [buylabel.text integerValue]){
    coinreq = [[UIAlertView alloc]initWithTitle:@"خرید" message:@"آیا از خرید این آهنگ مطمئن هستید؟" delegate:self cancelButtonTitle:@"خیر" otherButtonTitles:@"بله", nil];
        coinreq.tag = 6000;
        [coinreq show];
    }else{
        
        coinreqfaild = [[UIAlertView alloc]initWithTitle:@"سکه" message:@"مقدار سکه های شما برای این آهنگ کافی نیست!" delegate:self cancelButtonTitle:@"انصراف" otherButtonTitles:@"خرید سکه", nil];
        coinreqfaild.tag = 7000;
        [coinreqfaild show];
    }
}

-(void)microclicked{
     NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSString *purchase = @"NO";
    NSString *answe = @"buyed";
    if (([purchase isEqualToString:@"NO"]) || ([answe isEqualToString:@"buyed"])) {
        NSString *path = NSHomeDirectory();
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd.mp4",tag]];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (fileExists == NO){
           // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            // Set the determinate mode to show task progress.
           // hud.mode = MBProgressHUDModeDeterminate;
          //  hud.labelText = NSLocalizedString(@"Loading...", @"HUD loading title");
            
            // Configure the button.
            
           // [hud.button setTitle:NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
           // [hud.button addTarget:self action:@selector(cancelWork:) forControlEvents:UIControlEventTouchUpInside];
            

            
            alert = [[UIAlertView alloc] initWithTitle:@"Waiting(در حال دانلود کردن)" message:@"The files are downloading...(0/3)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
            alert.tag = 800;
            [alert show];
    
                NSLog(@"Downloading Started");
                NSString *urlToDownload = [NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-asli.mp3",tag,tag];
                namepath = @"-asli.mp3";
                NSURL *url = [NSURL URLWithString:urlToDownload];

                
                NSURLRequest *theRequest = [NSURLRequest requestWithURL: url];
                _theConnection = [[NSURLConnection alloc] initWithRequest: theRequest delegate: self startImmediately: YES];
                

            
        }else{
            
            
            BetviewController *viewController = [[BetviewController alloc] init];
            viewController.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:viewController animated:YES];

        }
    }else{
        alertpurch = [[UIAlertView alloc] initWithTitle:@"خرید" message:@"آیا شما مایل به خرید آهنگ بی کلام با قیمت ۱۰۰۰ تومان هستید؟" delegate:self cancelButtonTitle:@"خیر" otherButtonTitles:@"بله", nil];
        [alertpurch show];
        

        
        
    }

}




-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // INITIALIZE THE DOWNLOAD BUFFER
    _buffer = [NSMutableData data];
    expectedBytes = response.expectedContentLength;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    // APPEND DATA TO BUFFER
    [self.buffer appendData: data];

    float progress = ((100.0/expectedBytes)*self.buffer.length)/100;
    //NSLog(@"%f",progress);
    progress = progress * 100;
    switch (counter) {
        case 0:
            [alert setMessage:[NSString stringWithFormat:@"The files are downloading...(0/3)%.1f%%",progress]];
            break;
        case 1:
            [alert setMessage:[NSString stringWithFormat:@"The files are downloading...(1/3)%.1f%%",progress]];
            break;
        case 2:
            [alert setMessage:[NSString stringWithFormat:@"The files are downloading...(2/3)%.1f%%",progress]];
            break;
            
        default:
            break;
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    counter +=1;
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString*filename1= [NSString stringWithFormat:@"%zd%@",tag,namepath];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename1];
    [self.buffer writeToFile:filePath atomically:YES];
    if (counter == 1){
    NSLog(@"File Saved ,1 !");
    [alert setMessage:@"The files are downloading...(1/3)"];
    [self seconddownload];
    } else if (counter == 2){
        NSLog(@"File Saved ,2 !");
        [alert setMessage:@"The files are downloading...(2/3)"];
        [self thirddownload];
    }else if (counter == 3){
        NSLog(@"File Saved ,3 !");
        [alert setMessage:@"The files are downloading...(3/3)"];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        BetviewController *viewController = [[BetviewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    NSLog(@"%zd",alertView.tag);
    if ((buttonIndex == 1) && (alertView.tag == 100)){
        int sa = 1;
        [[NSUserDefaults standardUserDefaults] setInteger:sa forKey:@"TYPE"];
        TestingViewController *NVC = [[TestingViewController alloc] init];
        NVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:NVC animated:YES];
    } else if(buttonIndex == 1){
     /*   NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString *post = @"sku=hp_5710dd52dd3e6177602617&device_id=";
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
        
        PaymentViewController *viewController = [[PaymentViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];*/
        
        
    }
    
    if ((buttonIndex == 1) && (coinreq.tag == 6000)) {
       // NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
        NSString *sendData = @"username=khanandeappmostafa";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        sendData = [sendData stringByAppendingString:@"&password=Morteza09166414783"];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        NSString *email = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Email"];
        
        sendData = [sendData stringByAppendingString:@"&email="];
        sendData = [sendData stringByAppendingString:email];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        
        sendData = [sendData stringByAppendingString:@"&version="];
        sendData = [sendData stringByAppendingString:@"1"];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        sendData = [sendData stringByAppendingString:@"&songID="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%zd",tag]];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/buy-song-v2.php"]]];
        
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
            buy.hidden = YES;
            buylabel.hidden = YES;
            micro.hidden = NO;
            singlabel.hidden = NO;
            
        }
        
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"پرداخت" message:@"خرید با موفقیت انجام شد." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles:nil, nil];
        [alert1 show];
    }
    
    
    if (buttonIndex == 1 && coinreqfaild.tag == 7000) {
        CoinTableViewController *viewcon = [[CoinTableViewController alloc]init];
        [self.navigationController pushViewController:viewcon animated:YES];
    }
    
    if ((buttonIndex == 0) && (alert.tag == 800)) {
        [_theConnection cancel];
        _buffer = nil;
        counter = 0;

    }
    
    if ((buttonIndex == 0) && (alertView.tag == 100)){
        int sa = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:sa forKey:@"TYPE"];
        TestingViewController *NVC = [[TestingViewController alloc] init];
        NVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:NVC animated:YES];
    }
    
    



}


-(void)seconddownload{
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
        NSLog(@"Downloading Started");
        NSString *urlToDownload = [NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.mp3",tag,tag];
        namepath = @".mp3";
        NSURL *url = [NSURL URLWithString:urlToDownload];

        NSURLRequest *theRequest = [NSURLRequest requestWithURL: url];
        _theConnection = [[NSURLConnection alloc] initWithRequest: theRequest delegate: self startImmediately: YES];
    
}

-(void)thirddownload{
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
        NSLog(@"Downloading Started");
        NSString *urlToDownload = [NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.mp4",tag,tag];
        namepath = @".mp4";
        NSURL *url = [NSURL URLWithString:urlToDownload];
        
        NSURLRequest *theRequest = [NSURLRequest requestWithURL: url];
        _theConnection = [[NSURLConnection alloc] initWithRequest: theRequest delegate: self startImmediately: YES];
    
}






-(void)productPurchaseFailed:(NSNotification *)notification{
    NSLog(@"faild");
}
-(void)productPurchased:(NSNotification *)notification{
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSLog(@"%@",udid);
    NSString *sendData = @"username=khanandeappmostafa";
    sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
    
    sendData = [sendData stringByAppendingString:@"&password=Morteza09166414783"];
    sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
    
    sendData = [sendData stringByAppendingString:@"&UDID="];
    sendData = [sendData stringByAppendingString:udid];
    sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-buy-UDID.php?dl=1",tag,tag]]];
    
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
        [self faildserver];
    }
}

-(void)faildserver{
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSLog(@"%@",udid);
    NSString *sendData = @"username=khanandeappmostafa";
    sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
    
    sendData = [sendData stringByAppendingString:@"&password=Morteza09166414783"];
    sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
    
    sendData = [sendData stringByAppendingString:@"&UDID="];
    sendData = [sendData stringByAppendingString:udid];
    sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@""]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd-buy-UDID.php?dl=1",tag,tag]]];
    
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
        [self faildserver];
    }

}


-(void)playstopclick{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    if (play == false){
        [playstop setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        play = true;
        
        [player play];
        
    }else if (play == true){
        [playstop setImage:[UIImage imageNamed:@"play-button-black.png"] forState:UIControlStateNormal];
        play = false;
        [player stop];
    }

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    NSLog(@"stopppp");
    
    [playstop setImage:[UIImage imageNamed:@"play-button-black.png"] forState:UIControlStateNormal];
    play = false;
}

@end

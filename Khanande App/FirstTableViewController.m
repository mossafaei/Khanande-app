//
//  FirstTableViewController.m
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "FirstTableViewController.h"

@interface FirstTableViewController ()
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end

@implementation FirstTableViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    refreshControlbottom = nil;
    [refreshControlbottom removeFromSuperview];
    self.tableView.bottomRefreshControl =nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
    activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2-100/2, self.view.frame.size.height/2-100/2, 100.0f, 100.0f);
   //******* [self.view addSubview:activityIndicatorView];
    refreshControlbottom = [UIRefreshControl new];
    refreshControlbottom.triggerVerticalOffset = 100.;
    [refreshControlbottom addTarget:self action:@selector(refreshbottom) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControlbottom;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tabBarController.tabBar.hidden = NO;
    
    
    self.title = @"New Songs";
    
    customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:@"200" forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:@"coin.png"] forState:UIControlStateNormal];
    [customButton sizeToFit];
    customButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    customButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    customButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    [customButton addTarget:self action:@selector(coinbutton) forControlEvents:UIControlEventTouchUpInside];
   // self.navigationItem.leftBarButtonItem = customBarButtonItem;
    
    
    
    //NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *email = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"Email"];
    AFHTTPSessionManager *managercoin = [AFHTTPSessionManager manager];
    managercoin.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameterscoin = @{@"email":email};
    [managercoin GET:@"http://mspdeveloper.ir/app/getCredit-v2.php" parameters:parameterscoin progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"Coin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //customBarButtonItem.title=str;
        //[customBarButtonItem setTitle:str];
        //NSLog(@"%@",str);
         customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setTitle:str forState:UIControlStateNormal];
        [customButton setImage:[UIImage imageNamed:@"coin.png"] forState:UIControlStateNormal];
        [customButton sizeToFit];
        customButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        customButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        customButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        [customButton addTarget:self action:@selector(coinbutton) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = customBarButtonItem;
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
    }];
}



- (IBAction)newsongsback:(UIStoryboardSegue *)segue {
    // reset UI elements etc here
}

-(void)loadView
{
    [super loadView];
    NSURL*url = [NSURL URLWithString:@"http://www.mspdeveloper.ir/app/collection/collec.txt"];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    array = [[NSArray alloc]init];
    array = [str componentsSeparatedByString:@"?"];
    myCoverimage = [[NSMutableArray alloc]init];
    for (int i=0;i<[array count];i++){
        NSArray *array2 = [[NSArray alloc]init];
        array2 = [array[i] componentsSeparatedByString:@"#"];
        [myCoverimage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/collection/%@.jpg",array2[0]]];
    }
    
    const NSInteger numberOfTableViewRows = 1;
    const NSInteger numberOfCollectionViewCells = [array count];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
    
    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++)
    {
        NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
        
        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++)
        {
            
            CGFloat red = arc4random() % 255;
            CGFloat green = arc4random() % 255;
            CGFloat blue = arc4random() % 255;
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
            
            [colorArray addObject:color];
        }
        
        [mutableArray addObject:colorArray];
    }
    
    self.colorArray = [NSArray arrayWithArray:mutableArray];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (tableviewloaded == false) {
             [activityIndicatorView startAnimating];
    }
    refreshControlbottom = [UIRefreshControl new];
    refreshControlbottom.triggerVerticalOffset = 100.;
    [refreshControlbottom addTarget:self action:@selector(refreshbottom) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = refreshControlbottom;
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSURL*url = [NSURL URLWithString:@"http://www.mspdeveloper.ir/app/Version.txt"];
    NSString *versionserver = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    float ver12 = [version floatValue];
    float versaerver12 = [versionserver floatValue];
 
    if (ver12 < versaerver12) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"آپدیت" message:@"لطفا برنامه را آپدیت کنید." delegate:self cancelButtonTitle:nil otherButtonTitles:@"آپدیت", nil];
        alert.tag = 100;
        [alert show];
    }
}

-(void)coinbutton{
    CoinTableViewController *view = [[CoinTableViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tableviewloaded = YES;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [revealButtonItem setTarget: self.revealViewController];
        [revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    NSString *email = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Email"];
    NSDictionary *parameters1 = @{@"email" : email};
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager1 GET:@"http://mspdeveloper.ir/firstVisitCheck.php" parameters:parameters1 progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([str isEqualToString:@"0"]) {
            alertdavat = [[UIAlertView alloc] initWithTitle:@"کد دعوت" message:@"اگر به برنامه دعوت شدید کد دعوت خود را وارد کنید." delegate:self cancelButtonTitle:@"کد دعوت ندارم" otherButtonTitles: @"تایید",nil];
            alertdavat.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertdavat.tag = 700;
            [alertdavat show];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
    pagenumber =1;
    make =0;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
  //  SettingViewController *viewController = [[SettingViewController alloc] init];
  //  viewController.view.backgroundColor = [UIColor whiteColor];
   // [self.navigationController pushViewController:viewController animated:YES];
    
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               [NSString stringWithFormat:@"test.caf"],
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session1 = [AVAudioSession sharedInstance];
    [session1 setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSettings error:nil];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    [recorder record];
    [recorder stop];
    
    
    //self.title = @"New Songs";
    
    // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:38 green:38 blue:38 alpha:1];
    // self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:38 green:38 blue:38 alpha:1];
    //  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    //  NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    
    // SDImageCache *imageCache = [SDImageCache sharedImageCache];
    // [imageCache clearMemory];
    // [imageCache clearDisk];
    
    // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:207.0/255.0 green:0.0/255.0 blue:15.0/255.0 alpha:0.1]];
    //  [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    // [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
   // refreshControl = [[UIRefreshControl alloc]init];
   // [self.tableView addSubview:refreshControl];
   // [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
   // topRefreshControl = [UIRefreshControl new];
  //  topRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull down to reload!"];
  //  [topRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
  //  [scrollView addSubview:topRefreshControl];
    
    

    
     myImage = [[NSMutableArray alloc] init];
    mySongName = [[NSMutableArray alloc]init];
    myArtistName = [[NSMutableArray alloc]init];
    myCost = [[NSMutableArray alloc]init];
    
    NSURL*url = [NSURL URLWithString:@"http://www.mspdeveloper.ir/app/number.txt"];
    numberfile = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    myInt = [numberfile intValue];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"page":@"1"};
    [manager GET:@"http://mspdeveloper.ir/app/send-maininfo.php" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSString *stringdeppedn = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        arraydeappend = [stringdeppedn componentsSeparatedByString:@"?"];
        for (int i =0; i<[arraydeappend count]; i++){
            NSArray*hashtagjoda = [arraydeappend[i] componentsSeparatedByString:@"#"];
            [myArtistName addObject:hashtagjoda[0]];
            [mySongName addObject:hashtagjoda[1]];
            [myCost addObject:hashtagjoda[2]];
            }
        
            for (NSUInteger i = myInt - make  ; i >= myInt - make - [arraydeappend count] + 1; i--) {
                [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",  i, i]];
            }
       
        make += [arraydeappend count];
           // make = [arraydeappend count];
        
            if (![self connected]) {
                UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Internet connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alet show];
               // [refreshControl endRefreshing];
            }else{
                [self.tableView reloadData];
                [activityIndicatorView stopAnimating];
            }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

   
    
    // Do any additional setup after loading the view, typically from a nib.



    
 }


-(void)refreshbottom{
    [refreshControlbottom endRefreshing];
    if (myInt - make >= [arraydeappend count]){
    
    
        pagenumber +=1;
    
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%zd",pagenumber]};
        [manager GET:@"http://mspdeveloper.ir/app/send-maininfo.php" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSString *stringdeppedn = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            arraydeappend = [stringdeppedn componentsSeparatedByString:@"?"];
            for (int i =0; i<[arraydeappend count]; i++){
                NSArray*hashtagjoda = [arraydeappend[i] componentsSeparatedByString:@"#"];
                [myArtistName addObject:hashtagjoda[0]];
                [mySongName addObject:hashtagjoda[1]];
                [myCost addObject:hashtagjoda[2]];
            }
            NSLog(@"%zd",[arraydeappend count]);
            
            for (NSUInteger i = myInt - make  ; i >= myInt - make - [arraydeappend count] +1; i--) {
                [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",  i, i]];
            }
            
            make += [arraydeappend count];
            if (![self connected]) {
                UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Internet connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alet show];
                // [refreshControl endRefreshing];
            }else{
                [self.tableView reloadData];
            }
            
            
            
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
        
        
    }else if (myInt - make < [arraydeappend count] && myInt - make != 0) {
        
        pagenumber +=1;
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%zd",pagenumber]};
        [manager GET:@"http://mspdeveloper.ir/app/send-maininfo.php" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSString *stringdeppedn = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            arraydeappend = [stringdeppedn componentsSeparatedByString:@"?"];
            for (int i =0; i<[arraydeappend count]; i++){
                NSArray*hashtagjoda = [arraydeappend[i] componentsSeparatedByString:@"#"];
                [myArtistName addObject:hashtagjoda[0]];
                [mySongName addObject:hashtagjoda[1]];
                [myCost addObject:hashtagjoda[2]];
            }
            NSLog(@"%zd",[arraydeappend count]);
            
            for (NSUInteger i = myInt - make  ; i >= myInt - make - [arraydeappend count] +1; i--) {
                [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",  i, i]];
            }
            
            make += [arraydeappend count];
            if (![self connected]) {
                UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Internet connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alet show];
                // [refreshControl endRefreshing];
            }else{
                [self.tableView reloadData];
            }
            
            
            
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        

        
    }else if (myInt - make == 0){
        [refreshControlbottom endRefreshing];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)refreshTable {

       //  [refreshControl endRefreshing];
    countsection = 0;
    [myImage removeAllObjects];

    NSURL*url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/number.txt?dl=1"]];
    numberfile = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    myInt = [numberfile intValue];
    myImage = [[NSMutableArray alloc] init];

    
    for (NSUInteger i = myInt; i >= 1; i--) {
      //  int b = arc4random() % 1000000;
        [myImage addObject:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg", i,i]];

    }
    // Do any additional setup after loading the view, typically from a nib.
    if ([myImage count] % 2 == 0 ) {
        make = [myImage count]/2;
    }else{
        make = ([myImage count]/2)+1;
    }
    
    
    if (![self connected]) {
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Internet connection is not available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alet show];
       // [refreshControl endRefreshing];
    }else{
    [self.tableView reloadData];
        
    }

   

}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2*make+1;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"CellIdentifier";
        
        AFTableViewCell *cell = (AFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[AFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        return cell;
    }
    
    if ((indexPath.row % 2 == 0) && (indexPath.row != 0)){
        static NSString *simpleTableIdentifier = @"MusicItemTableViewCell";
        
        MusicItemTableViewCell *cell = (MusicItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MusicItemTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        strutl = myImage[(indexPath.row-2)/2];
        [cell.imagecover sd_setImageWithURL:[NSURL URLWithString:strutl] placeholderImage:[UIImage imageNamed:@"play-button-black.png"]];
        cell.artistlabel.text = myArtistName[(indexPath.row-2)/2];
        cell.songname.text = mySongName[(indexPath.row-2)/2];
         UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"rectangle130.png"]];
        cell.backgroundColor = background;
        
        if ([myCost[(indexPath.row-2)/2] isEqualToString:@"0"] ){
            [cell.button setTitle:@"Free" forState:UIControlStateNormal];
        }else{
            [cell.button setTitle:myCost[(indexPath.row-2)/2] forState:UIControlStateNormal];
        }
        
        cell.button.tag = myInt - ((indexPath.row-2)/2);
        [cell.button addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        

        
            return cell;
    } else if((indexPath.row % 2 != 0) && (indexPath.row !=0)) {
        
        static NSString *simpleTableIdentifier = @"BlackTableViewCell";
        
        BlackTableViewCell *cell = (BlackTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BlackTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        cell.hidden = YES;
        return cell;
        
        
    }else{
        return  nil;
    }

    

    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(AFTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
        NSInteger index = cell.collectionView.indexPath.row;
        NSLog(@"%zd",index);
        CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
        [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    }

}


-(void)yourButtonClicked:(UIButton*)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:sender.tag] forKey:@"TAG"];
    TestViewController *viewController = [[TestViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ((indexPath.row % 2 == 0) && (indexPath.row != 0)){
    //    NSLog(@"%zd",(indexPath.row-2)/2);
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:myInt - ((indexPath.row-2)/2)] forKey:@"TAG"];
        TestViewController *viewController = [[TestViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //if (indexPath.row == 0){
   // [refreshControl endRefreshing];
  //  }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // return self.view.frame.size.width/2;
    
    if (indexPath.row == 0){
        return self.view.frame.size.width*0.4;
    }
    
    if ((indexPath.row % 2 == 0) && (indexPath.row != 0)){
    //return 58;
        return 69;
    }else if((indexPath.row %2 !=0) && (indexPath.row !=0)){
    return 3;
    }else{
        return  3;
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


-(IBAction)addsong:(id)sender{
    alertsong = [[UIAlertView alloc] initWithTitle:@"Song Request(درخواست آهنگ جدید)" message:@"Please Write The Name of Your Requsted Song." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    alertsong.tag = 200;
    alertsong.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertsong show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100 && buttonIndex == 0) {
        NSString *iTunesLink = @"itms://itunes.apple.com/us/app/khanande-best-persian-farsi/id1097583206?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    
    if (alertView.tag == 700 && buttonIndex==1) {
         NSString *str = [alertdavat textFieldAtIndex:0].text;
       
        if ([str length] == 0 || str == nil) {
            

        NSString *email = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"Email"];

        NSDictionary *parameters = @{@"email" : email , @"InvCode" : str};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:@"http://www.mspdeveloper.ir/invitationCodeCheck.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *str1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([str1 isEqualToString:@"yes"]) {

            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"کد نامعتبر است." delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
                [alert show];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"خطا" message:@"خطا در شبکه" delegate:self cancelButtonTitle:@"باشه" otherButtonTitles: nil];
            [alert show];
        }];
        
        }
        
        
    }else if (alertView.tag == 700 && buttonIndex==0){
        
        NSString *email = [[NSUserDefaults standardUserDefaults]
                                            stringForKey:@"Email"];
        
        NSDictionary *parameters1 = @{@"email" : email};
        
        AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager1 POST:@"http://www.mspdeveloper.ir/firstVisit.php" parameters:parameters1 progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
    if (buttonIndex == 1 && alertView.tag == 200){
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



#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*0.4)];
    [image sd_setImageWithURL:[NSURL URLWithString:myCoverimage[indexPath.row]]];
    [cell addSubview:image];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array2 = [[NSArray alloc]init];
    array2 = [array[indexPath.row] componentsSeparatedByString:@"#"];
    
    if ([array2[1] isEqualToString:@"collec"]){
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[array2[0] intValue]] forKey:@"COLLECT_TAG"];
        CollecTableViewController *viewcontro = [[CollecTableViewController alloc]init];
        [self.navigationController pushViewController:viewcontro animated:YES];
        
    }else if ([array2[1] isEqualToString:@"nil"]){
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[array2[1] intValue]] forKey:@"TAG"];
        TestViewController *viewController = [[TestViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
        
        
    }

}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    AFIndexedCollectionView *collectionView = (AFIndexedCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
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

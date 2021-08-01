//
//  ShareViewController.m
//  Khanande App
//
//  Created by Apple on 9/10/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nobat = 0;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem*buttnitem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(barbuttonaction)];
    [[self navigationItem] setLeftBarButtonItem:buttnitem];
    self.navigationItem.hidesBackButton = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [player stop];
    
    NSString *path12 = NSHomeDirectory();
    path12 = [path12 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/jadid.m4a"]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path12 error: nil];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
       NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSString *path5 = NSHomeDirectory();
    path5 = [path5 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-record.caf",tag]];
    [[NSFileManager defaultManager] removeItemAtPath: path5 error: nil];
    
    NSString *path6 = NSHomeDirectory();
    path6 = [path6 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-record-echo-final.caf",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path6 error: nil];
    
    NSString *path7 = NSHomeDirectory();
    path7 = [path7 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd.caf",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path7 error: nil];
    
    NSString *path8 = NSHomeDirectory();
    path8 = [path8 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-record-echo.caf",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path8 error: nil];
    
    
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"CAMERA"];
    self.view.backgroundColor = [UIColor blackColor];
    NSString *path1 = NSHomeDirectory();
    path1 = [path1 stringByAppendingPathComponent:@"Documents/jadid.m4a"];
    NSLog(@"%@",savedValue);
    if ([savedValue isEqualToString:@"OFF"]){
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path1] error:nil];
    player.numberOfLoops = -1;
    player.delegate = self;
    [player play];
    }
   // NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    
    UIImageView*imagecover = [[UIImageView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 60, self.view.frame.size.width*2, self.view.frame.size.width*2)];
    imagecover.alpha = 0.3;
    [self.view addSubview:imagecover];
   // int b = arc4random() % 1000000;
    [imagecover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",tag,tag]]];
    

    
    if ([savedValue isEqualToString:@"OFF"]){
    playpause = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2+60, self.view.frame.size.width, self.view.frame.size.width)];
    [playpause setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    [playpause addTarget:self action:@selector(playpa) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:playpause];
    }else{
        
        NSString *path9 = NSHomeDirectory();
        path9 = [path9 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-uservideo.mp4",tag]];
        
        [[NSFileManager defaultManager] removeItemAtPath: path9 error: nil];
        
        NSString *path10 = NSHomeDirectory();
        path10 = [path10 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/finalvideo-%zd.mov",tag]];
        
        [[NSFileManager defaultManager] removeItemAtPath: path10 error: nil];
        
        NSString *path11 = NSHomeDirectory();
        path11 = [path11 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/jadid.m4a"]];
        
        [[NSFileManager defaultManager] removeItemAtPath: path11 error: nil];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString*filename1= [NSString stringWithFormat:@"%zd-exported.mov",tag];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename1];
        
       
        mpc=[[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath isDirectory:NO]];
        [mpc.view setFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2+60, self.view.frame.size.width, self.view.frame.size.width)];
        CGRect rectmovie = mpc.view.frame;
        rectmovie.size.width = self.view.frame.size.width;
        rectmovie.size.height  = self.view.frame.size.width/2;
        rectmovie.origin.x = 0;
        rectmovie.origin.y = self.view.frame.size.height/2-rectmovie.size.height/2;
        mpc.view.frame = rectmovie;
        [mpc prepareToPlay];
        [mpc setShouldAutoplay:YES]; // And other options you can look through the documentation.
        [mpc setControlStyle:MPMovieControlStyleDefault];
        mpc.repeatMode = MPMovieRepeatModeOne;
        [self.view addSubview:mpc.view];
        
        
        
        
    }
    
    save = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+self.view.frame.size.width/4, 60, self.view.frame.size.width/4, self.view.frame.size.width/4)];
    [save setImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveingvideo) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:save];
    

}

-(void)playpa{
    if(nobat == 0){
        [playpause setImage:[UIImage imageNamed:@"play-button-black.png"] forState:UIControlStateNormal];
        [player pause];
        nobat = 1;
    }else if (nobat == 1){
        [playpause setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [player play];
        nobat = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveingvideo{
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSString *path1 = NSHomeDirectory();
    path1 = [path1 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-exported.mov",tag]];
    
    NSURL*url = [[NSURL alloc] initFileURLWithPath:path1];
    NSArray * activityItems = @[url];
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:NULL];
    [self presentViewController:activityController animated:YES completion:nil];
    
}

-(void)barbuttonaction{
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"CAMERA"];
    if ([savedValue isEqualToString:@"ON"]) {
        [mpc stop];
        
    }
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SWRevealViewController *main = (SWRevealViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:main animated:YES completion:nil];
    
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSString *path12 = NSHomeDirectory();
    path12 = [path12 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-exported.mov",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path12 error: nil];
    
}


@end

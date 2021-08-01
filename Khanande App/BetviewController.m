//
//  BetviewController.m
//  Khanande
//
//  Created by Apple on 5/18/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "BetviewController.h"

@interface BetviewController ()

@end

@implementation BetviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    
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
    
    
    NSString *path9 = NSHomeDirectory();
    path9 = [path9 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-uservideo.mp4",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path9 error: nil];
    
    NSString *path10 = NSHomeDirectory();
    path10 = [path10 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/finalvideo-%zd.mov",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path10 error: nil];
    
    NSString *path11 = NSHomeDirectory();
    path11 = [path11 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/jadid.m4a"]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path11 error: nil];
    
    
    NSString *path12 = NSHomeDirectory();
    path12 = [path12 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-exported.mov",tag]];
    
    [[NSFileManager defaultManager] removeItemAtPath: path12 error: nil];


    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    
    self.title = @"Setting";
    
    
   imagecover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width/2+self.view.frame.size.width/3)];
    imagecover.image = [UIImage imageNamed:@"videono.png"];
    imagecover.hidden = YES;
    [self.view addSubview:imagecover];
    
    
     frameForCapture = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width/2+self.view.frame.size.width/3)];

    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetMedium];
    
    AVCaptureDevice *inputDevice = [self frontCamera];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    
    if ([session canAddInput:deviceInput]){
        [session addInput:deviceInput];
    }
    
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootlayer  = [[self view] layer];
    [rootlayer setMasksToBounds:YES];
    CGRect frame = frameForCapture.frame;
    
    [previewLayer setFrame:frame];
    [rootlayer insertSublayer:previewLayer atIndex:0];
    [previewLayer.connection  setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    movieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
    [session addOutput:movieFileOutput];
    [session commitConfiguration];
    [session startRunning];
    
    
    videoswitch = [[UISwitch alloc] initWithFrame:CGRectMake(frameForCapture.frame.size.width/2,frameForCapture.frame.size.height + 10 + 60 , 0, 0)];
    
    CGRect rect;
    rect = videoswitch.frame;
    rect.origin.x = rect.origin.x - (videoswitch.frame.size.width/2);
    videoswitch.frame = rect;
    [videoswitch setOn:YES animated:YES];
    [videoswitch addTarget:self action:@selector(videowithchange:) forControlEvents:UIControlEventValueChanged];
    [videoswitch setOnTintColor:[UIColor colorWithRed:0.0/255.0  green:117.0/255.0  blue:117.0/255.0  alpha:1.0f]];
    [self.view addSubview:videoswitch];

    start = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/10, self.view.frame.size.width, self.view.frame.size.height/10)];
    [start setBackgroundImage:[UIImage imageNamed:@"singButton.png"] forState:UIControlStateNormal];
    //[start setTitle:@"Sing!" forState:UIControlStateNormal];
    [start addTarget:self
                 action:@selector(startsing)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];

    
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"صدای خواننده",@"صدای کاربر"]];
    UIFont *font = [UIFont fontWithName:@"BYekan" size:15];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [segmentControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    int sa = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:sa forKey:@"TYPE"];
    
    segmentControl.frame = CGRectMake(0, ((videoswitch.frame.origin.y+videoswitch.frame.size.height+start.frame.origin.y)/2) - (self.view.frame.size.height/20), self.view.frame.size.width, self.view.frame.size.height/10);
    [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    [segmentControl setTintColor:[UIColor colorWithRed:0.0/255.0  green:117.0/255.0  blue:117.0/255.0  alpha:1.0f]];
    [self.view addSubview:segmentControl];
    
 [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:@"CAMERA"];

}


-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            int sa = 1;
            [[NSUserDefaults standardUserDefaults] setInteger:sa forKey:@"TYPE"];
            break;}
        case 1:{
            int sa = 0;
            [[NSUserDefaults standardUserDefaults] setInteger:sa forKey:@"TYPE"];
            break;}
    }
}


-(void)videowithchange:(UISwitch *)switcht{

    if (videoswitch.on){
        imagecover.hidden = YES;
         [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:@"CAMERA"];
    }else{
        imagecover.hidden = NO;
         [[NSUserDefaults standardUserDefaults] setObject:@"OFF" forKey:@"CAMERA"];
    }


}


- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}

-(void)viewWillDisappear:(BOOL)animated{
    [imagecover removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated{
    
}


-(void)startsing{
   TestingViewController *viewController = [[TestingViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

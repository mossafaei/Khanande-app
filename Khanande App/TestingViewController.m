//
//  TestingViewController.m
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "TestingViewController.h"
#import "AudioProcessor.h"
@interface TestingViewController ()

@end

@implementation TestingViewController
@synthesize audioProcessor;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [imagecover removeFromSuperview];
    [mpc.view removeFromSuperview];
    [microred removeFromSuperview];
    [loadmicro removeFromSuperview];
    [label removeFromSuperview];
    [self.audioPlot removeFromSuperview];
    imagecover = nil;
    mpc = nil;
    microred = nil;
    loadmicro = nil;
    label = nil;
    self.audioPlot = nil;
    [audioProcessor stop];
        audioProcessor = nil;
   // [session1 stopRunning];
   // session1 = nil;
  //  movieFileOutput = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1.0];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"CAMERA"];
    
    
    endshomar = 0;
    //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    UIBarButtonItem*buttnitem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(barbuttonaction)];
    [[self navigationItem] setLeftBarButtonItem:buttnitem];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor blackColor];

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if ([savedValue isEqualToString:@"OFF"]){
    imagecover = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height)];

    [imagecover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",tag,tag]]];
    imagecover.alpha = 0.3;
    [self.view addSubview:imagecover];
    }
    
    NSInteger sa = [[NSUserDefaults standardUserDefaults] integerForKey:@"TYPE"];
    
    if (sa == 0) {
    audioProcessor = [[AudioProcessor alloc] init];
    [audioProcessor start];
    [audioProcessor setGain: [audioProcessor getGain]+1.6f];
    }
    
    if ([savedValue isEqualToString:@"OFF"]) {
        
    self.audioPlot = [[EZAudioPlotGL alloc] initWithFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, 100)];
    [self.view addSubview:self.audioPlot];
    
    }
    
   // AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
   // [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session category: %@", error.localizedDescription);
    }
    //[session setActive:YES error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session active: %@", error.localizedDescription);
    }
    if ([savedValue isEqualToString:@"OFF"]) {
    //
    // Customizing the audio plot's look
    self.audioPlot.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0];
    self.audioPlot.color           = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.audioPlot.plotType        = EZPlotTypeRolling;
    self.audioPlot.shouldFill      = YES;
    self.audioPlot.shouldMirror    = YES;
    //NSLog(@"outputs: %@", [EZAudioDevice outputDevices]);
    }
    //
    // Create the audio player
    //
    self.player = [EZAudioPlayer audioPlayerWithDelegate:self];
    self.player.shouldLoop = NO;

    
    // Override the output to the speaker
   // [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if (error)
    {
        NSLog(@"Error overriding output to the speaker: %@", error.localizedDescription);
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString*filename1= [NSString stringWithFormat:@"%zd.mp4",tag];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename1];
    
   
    
    if ([savedValue isEqualToString:@"ON"]){
        frameForCapture = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
        [self.view addSubview:frameForCapture];
        
        session1 = [[AVCaptureSession alloc] init];
        [session1 setSessionPreset:AVCaptureSessionPresetMedium];
        
        AVCaptureDevice *inputDevice = [self frontCamera];
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
        
        if ([session1 canAddInput:deviceInput]){
            [session1 addInput:deviceInput];
        }
        
        
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session1];
        [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        CALayer *rootlayer  = [[self view] layer];
        [rootlayer setMasksToBounds:YES];
        CGRect frame = frameForCapture.frame;
        
        [previewLayer setFrame:frame];
        [rootlayer insertSublayer:previewLayer atIndex:0];
        [previewLayer.connection  setVideoOrientation:AVCaptureVideoOrientationPortrait];
        
        movieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
        [session1 addOutput:movieFileOutput];
        [session1 commitConfiguration];
        [session1 startRunning];
    }
    
    
    
    
    if ([savedValue isEqualToString:@"OFF"]) {
    
    mpc=[[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath isDirectory:NO]];
    [mpc.view setFrame:CGRectMake(0, self.view.frame.size.height/2, 240, 160)];
    CGRect rectmovie = mpc.view.frame;
    rectmovie.size.width = self.view.frame.size.width;
    rectmovie.size.height  = self.view.frame.size.width/2;
    rectmovie.origin.x = 0;
    rectmovie.origin.y = self.view.frame.size.height/2-rectmovie.size.height/2;
    mpc.view.frame = rectmovie;
    [mpc prepareToPlay];
    [mpc setShouldAutoplay:YES]; // And other options you can look through the documentation.
    [mpc setControlStyle:MPMovieControlStyleNone];
    mpc.repeatMode = MPMovieRepeatModeNone;
    [self.view addSubview:mpc.view];
    }else{
        mpc=[[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath isDirectory:NO]];
        [mpc.view setFrame:CGRectMake(0, 0, 240, 160)];
        CGRect rectmovie = mpc.view.frame;
        rectmovie.size.width = self.view.frame.size.width;
        rectmovie.size.height  = self.view.frame.size.width/2;
        rectmovie.origin.x = 0;
        rectmovie.origin.y = frameForCapture.frame.origin.y + frameForCapture.frame.size.height;
        mpc.view.frame = rectmovie;
        [mpc prepareToPlay];
        [mpc setShouldAutoplay:YES]; // And other options you can look through the documentation.
        [mpc setControlStyle:MPMovieControlStyleNone];
        mpc.repeatMode = MPMovieRepeatModeNone;
        [self.view addSubview:mpc.view];
        
    }
    
    

    
    
     if ([savedValue isEqualToString:@"OFF"]) {
         
         
    microred = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone-red.png"]];
    CGRect rect2 = microred.frame;
    rect2.size.height =(self.view.frame.size.height-(mpc.view.frame.origin.y+mpc.view.frame.size.height));
    rect2.size.height = rect2.size.height*0.4;
    rect2.size.width = rect2.size.height;
    rect2.origin.x = self.view.frame.size.width/2 - rect2.size.width/2;
    rect2.origin.y = (self.view.frame.size.height-(mpc.view.frame.origin.y+mpc.view.frame.size.height));
    rect2.origin.y = (rect2.origin.y*1/2)+mpc.view.frame.origin.y+mpc.view.frame.size.height-rect2.size.height/2;
    microred.frame = rect2;
    [self.view addSubview:microred];
    
    loadmicro = [[UIImageView alloc] initWithFrame:CGRectMake(microred.frame.origin.x-10, microred.frame.origin.y-10, microred.frame.size.width+20, microred.frame.size.width+20)];
    loadmicro.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"1-1.gif"],[UIImage imageNamed:@"1-2.gif"],[UIImage imageNamed:@"1-3.gif"],[UIImage imageNamed:@"1-4.gif"],[UIImage imageNamed:@"1-5.gif"],[UIImage imageNamed:@"1-6.gif"],[UIImage imageNamed:@"1-7.gif"],[UIImage imageNamed:@"1-8.gif"],[UIImage imageNamed:@"1-8.gif"],[UIImage imageNamed:@"1-10.gif"],[UIImage imageNamed:@"1-11.gif"],[UIImage imageNamed:@"1-12.gif"], nil];
    
    loadmicro.animationDuration = 1.0f;
    loadmicro.animationRepeatCount = -1;
    [loadmicro startAnimating];
    [self.view addSubview: loadmicro];
    
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(loadmicro.frame.origin.x, loadmicro.frame.origin.y-20, loadmicro.frame.size.width, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
     
     }else{
         
         
        /* microred = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone-red.png"]];
         CGRect rect2 = microred.frame;
         rect2.size.height =(self.view.frame.size.height-(mpc.view.frame.origin.y+mpc.view.frame.size.height));
         rect2.size.height = rect2.size.height*0.4;
         rect2.size.width = rect2.size.height;
         rect2.origin.x = self.view.frame.size.width/2 - rect2.size.width/2;
         rect2.origin.y = (self.view.frame.size.height-(mpc.view.frame.origin.y+mpc.view.frame.size.height));
         rect2.origin.y = (rect2.origin.y*1/2)+mpc.view.frame.origin.y+mpc.view.frame.size.height-rect2.size.height/2;
         microred.frame = rect2;
         [self.view addSubview:microred];
         
         loadmicro = [[UIImageView alloc] initWithFrame:CGRectMake(microred.frame.origin.x-10, microred.frame.origin.y-10, microred.frame.size.width+20, microred.frame.size.width+20)];
         loadmicro.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"1-1.gif"],[UIImage imageNamed:@"1-2.gif"],[UIImage imageNamed:@"1-3.gif"],[UIImage imageNamed:@"1-4.gif"],[UIImage imageNamed:@"1-5.gif"],[UIImage imageNamed:@"1-6.gif"],[UIImage imageNamed:@"1-7.gif"],[UIImage imageNamed:@"1-8.gif"],[UIImage imageNamed:@"1-8.gif"],[UIImage imageNamed:@"1-10.gif"],[UIImage imageNamed:@"1-11.gif"],[UIImage imageNamed:@"1-12.gif"], nil];
         
         loadmicro.animationDuration = 1.0f;
         loadmicro.animationRepeatCount = -1;
         [loadmicro startAnimating];
         [self.view addSubview: loadmicro];
         
         
         
         label = [[UILabel alloc] initWithFrame:CGRectMake(loadmicro.frame.origin.x, loadmicro.frame.origin.y-20, loadmicro.frame.size.width, 20)];
         label.textAlignment = NSTextAlignmentCenter;
         label.textColor = [UIColor whiteColor];
         [self.view addSubview:label];*/
         
         
         
         
         
         
     }
    
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBack:) name:MPMoviePlayerLoadStateDidChangeNotification object:mpc];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endvideo) name:MPMoviePlayerPlaybackDidFinishNotification object:mpc];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoPlaybackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:mpc];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               [NSString stringWithFormat:@"%zd-record.caf",tag],
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
  //  AVAudioSession *session2 = [AVAudioSession sharedInstance];
  //  [session2 setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityHigh],
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
    

    
    //NSError *setCategoryErr = nil;
  //  NSError *activationErr  = nil;
   [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setMode:AVAudioSessionModeVoiceChat error:nil];
    [[AVAudioSession sharedInstance] setDelegate: self];
    [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioHardwareRouteChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(interruption:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:nil];
    
}


- (void)interruption:(NSNotification*)notification {
    // get the user info dictionary
    NSDictionary *interuptionDict = notification.userInfo;
    // get the AVAudioSessionInterruptionTypeKey enum from the dictionary
    NSInteger interuptionType = [[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey] integerValue];
    // decide what to do based on interruption type here...
    switch (interuptionType) {
        case AVAudioSessionInterruptionTypeBegan:
            NSLog(@"Audio Session Interruption case started.");
            // fork to handling method here...
            // EG:[self handleInterruptionStarted];
        
            break;
            
        case AVAudioSessionInterruptionTypeEnded:
            NSLog(@"Audio Session Interruption case ended.");
            // fork to handling method here...
            // EG:[self handleInterruptionEnded];
            break;
            
        default:
            NSLog(@"Audio Session Interruption Notification case default.");
            break;
    }
}


- (void)audioHardwareRouteChanged:(NSNotification *)notification {
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonUnknown:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonUnknown");
            break;
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // a headset was added or removed
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonNewDeviceAvailable");
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            // a headset was added or removed
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonOldDeviceUnavailable");
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonCategoryChange");//AVAudioSessionRouteChangeReasonCategoryChange
           
            break;
            
        case AVAudioSessionRouteChangeReasonOverride:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonOverride");
            break;
            
        case AVAudioSessionRouteChangeReasonWakeFromSleep:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonWakeFromSleep");
            break;
            
        case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory");
           // [mpc play];
           // [self.player play];
           // playerformicro.currentTime = self.player.currentTime;
           // [playerformicro play];
           // [recorder record];
            break;
            
        default:
            break;
    }
}


-(void)playBack:(MPMoviePlayerController *)movieplayer{
    if (mpc.playbackState == MPMoviePlaybackStatePlaying)
    {
    NSString *path = NSHomeDirectory();
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSInteger sa = [[NSUserDefaults standardUserDefaults] integerForKey:@"TYPE"];
        if (sa ==0) {
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd.mp3",tag]];
        }else{
           path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-asli.mp3",tag]];
        }
    NSURL *myURL = [NSURL URLWithString:path];
        playerformicro = [[AVAudioPlayer alloc] initWithContentsOfURL:myURL error:nil];
        [playerformicro prepareToPlay];
        //[playerformicro]
    [self openFileWithFilePathURL:myURL];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"CAMERA"];
        if ([savedValue isEqualToString:@"ON"]){
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectoryPath = [paths objectAtIndex:0];
            
            NSString *outputpathofmovie = [[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd-uservideo",tag]] stringByAppendingString:@".mp4"];
            NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputpathofmovie];
             [movieFileOutput startRecordingToOutputFileURL:outputURL recordingDelegate:self];
            
        }
        
        
        
    }
    
}


-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    NSLog(@"video finished");
    
    
}


-(void)timer{
    sec +=1;
    if(sec == 60){
        min +=1;
        sec =0;
    }
    label.text = [NSString stringWithFormat:@"%zd:%zd",min,sec];
}

-(void)endvideo{
    endshomar +=1;
    
    if (endshomar == 1){
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"CAMERA"];
          // dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            //   dispatch_async(dispatch_get_main_queue(), ^{
                   [recorder stop];
    

        if ([savedValue isEqualToString:@"ON"]){
        
            [movieFileOutput stopRecording];
        
        }
        
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   [self.player pause];
                  //    });
        //  });
    NSLog(@"recording stoped");
    SettingViewController *NVC = [[SettingViewController alloc]init];
    NVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:NVC animated:YES];
    
  //  });
    
    
    
    
    }
    
    }
    //[self presentViewController:NVC animated:YES completion:nil];


- (void)openFileWithFilePathURL:(NSURL *)filePathURL
{
    [self.player pause];

    self.audioFile = [EZAudioFile audioFileWithURL:filePathURL];
    

    self.audioPlot.plotType = EZPlotTypeRolling;
    self.audioPlot.shouldFill = YES;
    self.audioPlot.shouldMirror = YES;
    __weak typeof (self) weakSelf = self;
    [self.audioFile getWaveformDataWithCompletionBlock:^(float **waveformData,
                                                         int length)
     {
         [weakSelf.audioPlot updateBuffer:waveformData[0]
                           withBufferSize:length];
     }];
    

    [self.player setAudioFile:self.audioFile];
    [self.player play];
    
    [recorder record];
    NSLog(@"recording");

}



- (void)  audioPlayer:(EZAudioPlayer *)audioPlayer
          playedAudio:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
          inAudioFile:(EZAudioFile *)audioFile
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.audioPlot updateBuffer:buffer[0]
                          withBufferSize:bufferSize];
    });
}

//------------------------------------------------------------------------------

- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
    updatedPosition:(SInt64)framePosition
        inAudioFile:(EZAudioFile *)audioFile
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        // if (!weakSelf.positionSlider.touchInside)
        // {
        //  weakSelf.positionSlider.value = (float)framePosition;
        //}
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)barbuttonaction{
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Quit" message:@"Are you sure you want to quit? You will lose all unfinished progress." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"CAMERA"];
            //dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
              //          dispatch_async(dispatch_get_main_queue(), ^{
        [self.player pause];
        [mpc pause];
        [recorder stop];
        
        if ([savedValue isEqualToString:@"ON"]){
            
            [movieFileOutput stopRecording];
            
        }
     // });
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        SWRevealViewController *main = (SWRevealViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:main animated:YES completion:nil];
       //  });
     
    }
}


-(void)videoPlaybackStateChanged{
    if (mpc != nil && [mpc playbackState] == MPMoviePlaybackStatePaused)
    {
        [mpc play];
    }
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

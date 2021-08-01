//
//  SettingViewController.m
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController{

        NSString *cellClassName;
        CGFloat baseOffset;
        CGFloat offsetStep;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    centerferearray = @[@"60.0",@"170.0",@"310.0",@"600.0",@"1000.0",@"3000.0",@"6000.0",@"12000.0",@"14000.0",@"16000.0"];
    
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    
    audiocontroller = [[AEAudioController alloc] initWithAudioDescription:AEAudioStreamBasicDescriptionNonInterleavedFloatStereo];
    
    
    NSString *path1 = NSHomeDirectory();
    path1 = [path1 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd.mp3",tag]];
    musicplayer = [[AEAudioFilePlayer alloc] initWithURL:[NSURL fileURLWithPath:path1] error:nil];
    
    
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-record.caf",tag]];
    singerplayer = [[AEAudioFilePlayer alloc]initWithURL:[NSURL fileURLWithPath:path] error:nil];
    
    musicplayer.loop = YES;
    singerplayer.loop = YES;
    
    [audiocontroller addChannels:@[musicplayer,singerplayer]];
    

    eqparametric1 = [[AEParametricEqFilter alloc]init];
    eqparametric1.qFactor = 2.0;
    eqparametric1.gain = 0.0;
    eqparametric1.centerFrequency = [centerferearray[0] doubleValue];
    [audiocontroller addFilter:eqparametric1 toChannel:singerplayer];
    
    
    eqparametric2 = [[AEParametricEqFilter alloc]init];
    eqparametric2.qFactor = 2.0;
    eqparametric2.gain = 0.0;
    eqparametric2.centerFrequency = [centerferearray[1] doubleValue];
    [audiocontroller addFilter:eqparametric2 toChannel:singerplayer];
    
    
    eqparametric3 = [[AEParametricEqFilter alloc]init];
    eqparametric3.qFactor = 2.0;
    eqparametric3.gain = 0.0;
    eqparametric3.centerFrequency = [centerferearray[2] doubleValue];
    [audiocontroller addFilter:eqparametric3 toChannel:singerplayer];
    
    
    eqparametric4 = [[AEParametricEqFilter alloc]init];
    eqparametric4.qFactor = 2.0;
    eqparametric4.gain = 0.0;
    eqparametric4.centerFrequency = [centerferearray[3] doubleValue];
    [audiocontroller addFilter:eqparametric4 toChannel:singerplayer];
    
    
    eqparametric5 = [[AEParametricEqFilter alloc]init];
    eqparametric5.qFactor = 2.0;
    eqparametric5.gain = 0.0;
    eqparametric5.centerFrequency = [centerferearray[4] doubleValue];
    [audiocontroller addFilter:eqparametric5 toChannel:singerplayer];
    
    
    eqparametric6 = [[AEParametricEqFilter alloc]init];
    eqparametric6.qFactor = 2.0;
    eqparametric6.gain = 0.0;
    eqparametric6.centerFrequency = [centerferearray[5] doubleValue];
    [audiocontroller addFilter:eqparametric6 toChannel:singerplayer];
    
    
    eqparametric7 = [[AEParametricEqFilter alloc]init];
    eqparametric7.qFactor = 2.0;
    eqparametric7.gain = 0.0;
    eqparametric7.centerFrequency = [centerferearray[6] doubleValue];
    [audiocontroller addFilter:eqparametric7 toChannel:singerplayer];
    
    
    eqparametric8 = [[AEParametricEqFilter alloc]init];
    eqparametric8.qFactor = 2.0;
    eqparametric8.gain = 0.0;
    eqparametric8.centerFrequency = [centerferearray[7] doubleValue];
    [audiocontroller addFilter:eqparametric8 toChannel:singerplayer];
    
    
    eqparametric9 = [[AEParametricEqFilter alloc]init];
    eqparametric9.qFactor = 2.0;
    eqparametric9.gain = 0.0;
    eqparametric9.centerFrequency = [centerferearray[8] doubleValue];
    [audiocontroller addFilter:eqparametric9 toChannel:singerplayer];
    
    
    eqparametric10 = [[AEParametricEqFilter alloc]init];
    eqparametric10.qFactor = 2.0;
    eqparametric10.gain = 0.0;
    eqparametric10.centerFrequency = [centerferearray[9] doubleValue];
    [audiocontroller addFilter:eqparametric10 toChannel:singerplayer];
    
    reverbfilter = [[AEReverbFilter alloc]init];
    reverbfilter.dryWetMix = 0;
    [audiocontroller addFilter:reverbfilter toChannel:singerplayer];
    
    [audiocontroller start:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // Don't forget to remove notification in dealloc method!!
    
     self.navigationController.navigationBar.hidden = NO;
    self.title = @"Mixing";
    UIBarButtonItem*buttnitem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(barbuttonaction)];
    [[self navigationItem] setLeftBarButtonItem:buttnitem];
    self.navigationItem.hidesBackButton = YES;
    

    
    
    
}





-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [audiocontroller stop];
    
    audiocontroller =nil;
    musicplayer = nil;
    singerplayer = nil;

}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];

      NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    [musicvol removeFromSuperview];
    [singervol removeFromSuperview];
    [imagecover removeFromSuperview];
    [musicvollabel removeFromSuperview];
    [singervollabel removeFromSuperview];
    [exportbutton removeFromSuperview];
    
   // [self combineVoiceskhali];
    int payeen = self.view.frame.size.width/60;

    
    
    imagecover = [[UIImageView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 60, self.view.frame.size.width*2, self.view.frame.size.width*2)];
    imagecover.alpha = 0.3;
    [self.view addSubview:imagecover];
    [imagecover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mspdeveloper.ir/app/%zd/%zd.jpg",tag,tag]]];
    
    
    
     musicvol = [[UISlider alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/2-self.view.frame.size.width/3+60 + payeen,self.view.frame.size.width, 20)];
    musicvol.minimumValue = -20.0f;
    musicvol.maximumValue = 20.0f;
    musicvol.value = 0.0;
    [musicvol addTarget:self action:@selector(slidermusicValueChanged:) forControlEvents:UIControlEventValueChanged];
     [self.view addSubview:musicvol];
    
    musicvollabel = [[UILabel alloc] initWithFrame:CGRectMake(0, musicvol.frame.origin.y-15, self.view.frame.size.width,20)];
    musicvollabel.text = @"Music Volume";
    [musicvollabel setTextColor:[UIColor whiteColor]];
    musicvollabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:musicvollabel];
    
    
    
    drywetslider = [[UISlider alloc]initWithFrame:CGRectMake(0, musicvol.frame.origin.y +40 +payeen, self.view.frame.size.width, 20)];
    [drywetslider addTarget:self action:@selector(drywetslider) forControlEvents:UIControlEventValueChanged];
    drywetslider.minimumValue = 0;
    drywetslider.maximumValue = 100;
    drywetslider.value = 0;
    [self.view addSubview:drywetslider];
    
    labelechoswitch = [[UILabel alloc] initWithFrame:CGRectMake(0,drywetslider.frame.origin.y -15, drywetslider.frame.size.width, 15)];
    [labelechoswitch setTextColor:[UIColor whiteColor]];
    labelechoswitch.textAlignment = NSTextAlignmentCenter;
    labelechoswitch.text = @"Reverb";
    [self.view addSubview:labelechoswitch];
    
    
    
     singervol = [[UISlider alloc] initWithFrame:CGRectMake(0, (drywetslider.frame.origin.y - musicvol.frame.origin.y) + drywetslider.frame.origin.y + payeen, self.view.frame.size.width, 20)];
    singervol.minimumValue = -20.0f;
    singervol.maximumValue = 20.0f;
    singervol.value = 0.0;
    [singervol addTarget:self action:@selector(slidersingerValueChanged:) forControlEvents:UIControlEventValueChanged];
     [self.view addSubview:singervol];
    
    singervollabel = [[UILabel alloc] initWithFrame:CGRectMake(0, singervol.frame.origin.y-15, self.view.frame.size.width,20)];
    singervollabel.text = @"Singer Volume";
    [singervollabel setTextColor:[UIColor whiteColor]];
    singervollabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:singervollabel];

    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, singervol.frame.origin.y + 30 +payeen, self.view.frame.size.width, 50) collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    cellClassName = NSStringFromClass([MyCell class]);
    [collectionView registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellWithReuseIdentifier:cellClassName];
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:collectionView];
    
    baseOffset = collectionView.contentOffset.x;
    

    int heighteq =self.view.frame.size.height-self.view.frame.size.height/10  - (singervol.frame.origin.y + 80 +payeen) ;
    //int heighteq = test - tmpEQ;
    int yEQ = singervol.frame.origin.y + 70 +payeen + heighteq/2;
    int kam = self.view.frame.size.width/22;
    int center = self.view.frame.size.width/2 - heighteq/2;
    
    slider1 = [[UISlider alloc]initWithFrame:CGRectMake(center-9*kam, yEQ ,heighteq, 20)];
    slider1.minimumValue = -20.0f;
    slider1.maximumValue = 20.0f;
    slider1.value =0.0f;
    slider1.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider1 addTarget:self action:@selector(slider1EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider1];



    slider2 = [[UISlider alloc]initWithFrame:CGRectMake(center-7*kam, yEQ , heighteq, 20)];
    slider2.minimumValue = -20.0f;
    slider2.maximumValue = 20.0f;
    slider2.value =0.0f;
    slider2.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider2 addTarget:self action:@selector(slider2EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider2];
    
    
    slider3 = [[UISlider alloc]initWithFrame:CGRectMake(center-5*kam, yEQ , heighteq, 20)];
    slider3.minimumValue = -20.0f;
    slider3.maximumValue = 20.0f;
    slider3.value =0.0f;
    slider3.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider3 addTarget:self action:@selector(slider3EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider3];
    
    
    slider4 = [[UISlider alloc]initWithFrame:CGRectMake(center-3*kam, yEQ , heighteq, 20)];
    slider4.minimumValue = -20.0f;
    slider4.maximumValue = 20.0f;
    slider4.value =0.0f;
    slider4.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider4 addTarget:self action:@selector(slider4EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider4];
    
    slider5 = [[UISlider alloc]initWithFrame:CGRectMake(center-1*kam, yEQ  , heighteq, 20)];
    slider5.minimumValue = -20.0f;
    slider5.maximumValue = 20.0f;
    slider5.value =0.0f;
    slider5.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider5 addTarget:self action:@selector(slider5EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider5];
    
    slider6= [[UISlider alloc]initWithFrame:CGRectMake(center+1*kam, yEQ , heighteq, 20)];
    slider6.minimumValue = -20.0f;
    slider6.maximumValue = 20.0f;
    slider6.value =0.0f;
    slider6.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider6 addTarget:self action:@selector(slider6EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider6];
    
    
    slider7 = [[UISlider alloc]initWithFrame:CGRectMake(center+3*kam, yEQ  , heighteq, 20)];
    slider7.minimumValue = -20.0f;
    slider7.maximumValue = 20.0f;
    slider7.value =0.0f;
    slider7.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider7 addTarget:self action:@selector(slider7EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider7];
    
    
    slider8 = [[UISlider alloc]initWithFrame:CGRectMake(center+5*kam, yEQ, heighteq, 20)];
    slider8.minimumValue = -20.0f;
    slider8.maximumValue = 20.0f;
    slider8.value =0.0f;
    slider8.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider8 addTarget:self action:@selector(slider8EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider8];
    
    
    
    slider9 = [[UISlider alloc]initWithFrame:CGRectMake(center+7*kam, yEQ, heighteq, 20)];
    slider9.minimumValue = -20.0f;
    slider9.maximumValue = 20.0f;
    slider9.value =0.0f;
    slider9.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider9 addTarget:self action:@selector(slider9EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider9];
    
    
    slider10 = [[UISlider alloc]initWithFrame:CGRectMake(center+9*kam, yEQ, heighteq, 20)];
    slider10.minimumValue = -20.0f;
    slider10.maximumValue = 20.0f;
    slider10.value =0.0f;
    slider10.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [slider10 addTarget:self action:@selector(slider10EQ) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider10];
    
    
    exportbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/10 , self.view.frame.size.width,self.view.frame.size.height/10)];
    //[exportbutton setTitle:@"Export" forState:UIControlStateNormal];
    [exportbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[exportbutton setImage:[UIImage imageNamed:@"export.png"] forState:UIControlStateNormal];
    [exportbutton setBackgroundImage:[UIImage imageNamed:@"exportButton.png"] forState:UIControlStateNormal];
    [exportbutton addTarget:self action:@selector(exportbuttonclick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:exportbutton];
    



    
}

-(void)drywetslider{
    reverbfilter.dryWetMix = drywetslider.value;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGFloat stepUnit = layout.itemSize.width + layout.minimumLineSpacing;
    offsetStep = stepUnit * floorf(collectionView.bounds.size.width / stepUnit);
}

-(void)slider1EQ{
    
    eqparametric1.gain = slider1.value;
}


-(void)slider2EQ{
    eqparametric2.gain = slider2.value;
}


-(void)slider3EQ{
    eqparametric3.gain = slider3.value;
}


-(void)slider4EQ{
    eqparametric4.gain = slider4.value;
}


-(void)slider5EQ{
    eqparametric5.gain = slider5.value;
}


-(void)slider6EQ{
    eqparametric6.gain = slider6.value;
}


-(void)slider7EQ{
    eqparametric7.gain = slider7.value;
}


-(void)slider8EQ{
    eqparametric8.gain = slider8.value;
}


-(void)slider9EQ{
    eqparametric9.gain = slider9.value;
}


-(void)slider10EQ{
    eqparametric10.gain = slider10.value;
}


-(void)echoswitchchange:(UISwitch *)switchecho{
    NSLog(@"%@", echoswitch.on ? @"On" : @"Off");
    
    if (echoswitch.on) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            //[audiocontroller addFilter:delayfilter toChannel:singerplayer];
            reverbfilter.dryWetMix = 50;
        }];
    
    
    }else{
        //[audiocontroller removeFilter:delayfilter fromChannel:singerplayer];
        reverbfilter.dryWetMix = 0;

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)slidermusicValueChanged:(UISlider *)sender {
    musicplayer.volume =pow(10.0f, (sender.value/20.0f));
}
- (void)slidersingerValueChanged:(UISlider *)sender {
    singerplayer.volume = pow(10.0f, (sender.value/20.0f));
}

-(void)exportbuttonclick{
    
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"CAMERA"];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
    
    if([savedValue isEqualToString:@"OFF"]){
        alert1 = [[UIAlertView alloc] initWithTitle:@"Waiting(در حال ساختن فایل نهایی)" message:@"Exporting audio...(0/2)" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        stralert = @"/2)";
        countalert = 0;
        [alert1 show];
    }else{
        alert1 = [[UIAlertView alloc] initWithTitle:@"Waiting(در حال ساختن فایل نهایی)" message:@"Exporting audio...(0/2)" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        stralert = @"/2)";
        countalert = 0;
        [alert1 show];
    }
    
        });

    [musicplayer setCurrentTime:0];
    [singerplayer setCurrentTime:0];
    [audiocontroller stop];

    


    const int kBufferLength = 4096;
    NSTimeInterval renderDuration = musicplayer.duration;
    Float64 sampleRate = audiocontroller.audioDescription.mSampleRate;
    UInt32 lengthInFrames = (UInt32) (renderDuration * sampleRate);
    AudioTimeStamp timeStamp;
    memset (&timeStamp, 0, sizeof(timeStamp));
    timeStamp.mFlags = kAudioTimeStampSampleTimeValid;
   // timeStamp.mSampleTime = 0;
    AEAudioFileWriter *audioFileWriter =
    [[AEAudioFileWriter alloc] initWithAudioDescription:audiocontroller.audioDescription];
    AudioBufferList *buf =
    AEAllocateAndInitAudioBufferList(audiocontroller.audioDescription, kBufferLength);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"jadid.m4a"];
    
    [audioFileWriter beginWritingToFileAtPath:txtPath fileType:kAudioFileM4AType error:nil];
    for (UInt64 i = 0; i < lengthInFrames; i += kBufferLength) {
        AEAudioControllerRenderMainOutput(audiocontroller, timeStamp, kBufferLength, buf);
        
        timeStamp.mSampleTime += kBufferLength;
        OSStatus status = AEAudioFileWriterAddAudioSynchronously(audioFileWriter, buf, kBufferLength);
        if (status != noErr) {
            NSLog(@"ERROR: %d", (int) status);
        }
    }
    [audioFileWriter finishWriting];
    AEFreeAudioBufferList(buf);
    NSLog(@"finish");
    countalert +=1;
    NSString *straler;
    straler = [NSString stringWithFormat:@"Exporting audio...(%zd%@",countalert,stralert];
    [alert1 setMessage:straler];

    if ([savedValue isEqualToString:@"OFF"]){

            NSString *path4 = NSHomeDirectory();
            path4 = [path4 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd.mp4",tag]];
            url5 = [NSURL fileURLWithPath:path4];
            
            NSString *path3 = NSHomeDirectory();
            path3 = [path3 stringByAppendingPathComponent:@"Documents/jadid.m4a"];
            NSURL *url1 = [NSURL fileURLWithPath:path3];
            
            [self mixvideowithaudio:url5 :url1];

        
    }else if ([savedValue isEqualToString:@"ON"]){
       
            NSString *path4 = NSHomeDirectory();
            path4 = [path4 stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%zd-uservideo.mp4",tag]];
            url5 = [NSURL fileURLWithPath:path4];
        
        NSString *path3 = NSHomeDirectory();
        path3 = [path3 stringByAppendingPathComponent:@"Documents/jadid.m4a"];
        NSURL *url10 = [NSURL fileURLWithPath:path3];
        [self mixvideowithaudio:url5 :url10];
           // [//self videoOutput:url5];
    
    }
   });
 
}




-(void)mixvideowithaudio:(NSURL *)videoURL : (NSURL *)audioURL{
    
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audioURL options:nil];
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:videoURL options:nil];
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration)
                                        ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                         atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                   preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                   ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                    atTime:kCMTimeZero error:nil];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"CAMERA"];
    
    if ([savedValue isEqualToString:@"ON"]) {
         compositionVideoTrack.preferredTransform = CGAffineTransformMakeRotation(M_PI_2);   
    }
    
    
    
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetMediumQuality];
    
    // NSString* videoName = @"exported.mov";
    
    // NSString *exportPath = [NSTemporaryDirectory() stringByAppendingPathComponent:videoName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *soundOneNew = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd-exported.mov",tag]];
    
    NSURL    *exportUrl = [NSURL fileURLWithPath:soundOneNew];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundOneNew])
    {
        [[NSFileManager defaultManager] removeItemAtPath:soundOneNew error:nil];
    }
    
    _assetExport.outputFileType = @"com.apple.quicktime-movie";
    _assetExport.outputURL = exportUrl;
    _assetExport.shouldOptimizeForNetworkUse = YES;
    
    [_assetExport exportAsynchronouslyWithCompletionHandler:^{
        
        if (AVAssetExportSessionStatusCompleted == _assetExport.status) {
            NSLog(@"video Completed");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                [alert1 dismissWithClickedButtonIndex:-1 animated:YES];
                          ShareViewController*viewController = [[ShareViewController alloc] init];
                          viewController.view.backgroundColor = [UIColor whiteColor];
                         [self.navigationController pushViewController:viewController animated:YES];
                
            }];
            
        } else if (AVAssetExportSessionStatusFailed == _assetExport.status) {
            // a failure may happen because of an event out of your control
            // for example, an interruption like a phone call comming in
            // make sure and handle this case appropriately
            NSLog(@"change volume record faild");
        } else {
            NSLog(@"change volume record : %zd", _assetExport.status);
        }
    }];
    
    
    
}



/*- (void)videoOutput:(NSURL *)urlvideoinput
{
    NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
    
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths1 objectAtIndex:0];
    
    // AVCaptureMovieFileOutput *movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    //NSString *archives = [documentsDirectoryPath stringByAppendingPathComponent:@"archives"];
    NSString *outputpathofmovie = [[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd-uservideo",tag]] stringByAppendingString:@".mp4"];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputpathofmovie];
    
    // 1 - Early exit if there's no video file selected
    self.videoAsset = [AVAsset assetWithURL:outputURL];
    
    // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    // 3 - Video track
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.videoAsset.duration)
                        ofTrack:[[self.videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
    
    // 3.1 - Create AVMutableVideoCompositionInstruction
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, self.videoAsset.duration);
    
    // 3.2 - Create an AVMutableVideoCompositionLayerInstruction for the video track and fix the orientation.
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    AVAssetTrack *videoAssetTrack = [[self.videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
    BOOL isVideoAssetPortrait_  = NO;
    CGAffineTransform videoTransform = videoAssetTrack.preferredTransform;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ = UIImageOrientationRight;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ =  UIImageOrientationLeft;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
        videoAssetOrientation_ =  UIImageOrientationUp;
    }
    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
        videoAssetOrientation_ = UIImageOrientationDown;
    }
    [videolayerInstruction setTransform:videoAssetTrack.preferredTransform atTime:kCMTimeZero];
    [videolayerInstruction setOpacity:0.0 atTime:self.videoAsset.duration];
    
    // 3.3 - Add instructions
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    } else {
        naturalSize = videoAssetTrack.naturalSize;
    }
    
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    
    [self applyVideoEffectsToComposition:mainCompositionInst size:naturalSize];
    // 4 - Get path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"finalvideo-%zd.mov",tag]];
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPathDocs];
    if (fileExists) {
    [[NSFileManager defaultManager] removeItemAtPath: myPathDocs error: nil];
    }
        // 5 - Create exporter
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=url;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.shouldOptimizeForNetworkUse = YES;
    exporter.videoComposition = mainCompositionInst;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exportDidFinish:exporter];
        });
    }];
    
}


- (void)exportDidFinish:(AVAssetExportSession*)session {
    if (session.status == AVAssetExportSessionStatusCompleted) {
                dispatch_async(dispatch_get_main_queue(), ^{
              
                    NSLog(@"saved");
                    
                    countalert +=1;
                    NSString *straler;
                    straler = [NSString stringWithFormat:@"Exporting audio...(%zd%@",countalert,stralert];
                    [alert1 setMessage:straler];

                     NSUInteger tag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] integerValue];
                    NSString *path3 = NSHomeDirectory();
                    path3 = [path3 stringByAppendingPathComponent:@"Documents/jadid.m4a"];
                    NSURL *url1 = [NSURL fileURLWithPath:path3];
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                             [NSString stringWithFormat:@"finalvideo-%zd.mov",tag]];
                    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
                    
                    [self mixvideowithaudio:url :url1];
             });
    }else if (AVAssetExportSessionStatusFailed == session.status){
        
        NSLog(@"faild");
    }
}


- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size
{
    // 1 - Set up the text layer
   */ /*CATextLayer *subtitle1Text = [[CATextLayer alloc] init];
    [subtitle1Text setFont:(__bridge CFTypeRef)@"Helvetica-Bold"];
    [subtitle1Text setFontSize:36];
    [subtitle1Text setFrame:CGRectMake(0, 0, size.width, 100)];
    [subtitle1Text setString:@"@khanandeapp"];
    [subtitle1Text setAlignmentMode:kCAAlignmentCenter];
    [subtitle1Text setForegroundColor:[[UIColor whiteColor] CGColor]];*/
    
 /*   UIImage *myImage = [UIImage imageNamed:@"512.png"];
    CALayer *aLayer = [CALayer layer];
    aLayer.contents = (id)myImage.CGImage;
    aLayer.frame = CGRectMake(5, 25, 57, 57); //Needed for proper display. We are using the app icon (57x57). If you use 0,0 you will not see it
    aLayer.opacity = 0.65;
    
    // 2 - The usual overlay
    CALayer *overlayLayer = [CALayer layer];
    [overlayLayer addSublayer:aLayer];
    overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [overlayLayer setMasksToBounds:YES];
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
}
*/


-(void)barbuttonaction{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SWRevealViewController *main = (SWRevealViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:main animated:YES completion:nil];
    
}



#pragma mark - UICollectionViewDataSource protocol

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 18;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellClassName forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.item) {
        case 0:
            cell.image.image = [UIImage imageNamed:@"none.png"];//porrang
            break;
        case 1:
            cell.image.image = [UIImage imageNamed:@"rock.png"];
            break;
        case 2:
            cell.image.image = [UIImage imageNamed:@"pop.png"];
            break;
        case 3:
            cell.image.image = [UIImage imageNamed:@"classic.png"];
            break;
        case 4:
            cell.image.image = [UIImage imageNamed:@"soft.png"];
            break;
        case 5:
            cell.image.image = [UIImage imageNamed:@"live.png"];
            break;
        case 6:
            cell.image.image = [UIImage imageNamed:@"dance.png"];
            break;
        case 7:
            cell.image.image = [UIImage imageNamed:@"soft-rock.png"];
            break;
        case 8:
            cell.image.image = [UIImage imageNamed:@"headphone.png"];
            break;
        case 9:
            cell.image.image = [UIImage imageNamed:@"party.png"];
            break;
        case 10:
            cell.image.image = [UIImage imageNamed:@"club.png"];
            break;
        case 11:
            cell.image.image = [UIImage imageNamed:@"full-base2.png"];
            break;
        case 12:
            cell.image.image = [UIImage imageNamed:@"full-bass.png"];
            break;
        case 13:
            cell.image.image = [UIImage imageNamed:@"full-treble.png"];
            break;
        case 14:
            cell.image.image = [UIImage imageNamed:@"ska.png"];
            break;
        case 15:
            cell.image.image = [UIImage imageNamed:@"techno.png"];
            break;
        case 16:
            cell.image.image = [UIImage imageNamed:@"large-hall.png"];
            break;
        case 17:
            cell.image.image = [UIImage imageNamed:@"reggae.png"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger itemselct = indexPath.row;
    NSLog(@"select : %zd",itemselct);
    switch (itemselct) {
        case 0:
            eqparametric1.gain = 0;
            eqparametric2.gain =0;
            eqparametric3.gain = 0;
             eqparametric4.gain = 0;
             eqparametric5.gain = 0;
             eqparametric6.gain = 0;
             eqparametric7.gain = 0;
             eqparametric8.gain = 0;
             eqparametric9.gain = 0;
             eqparametric10.gain = 0;
            slider1.value = 0;
            slider2.value = 0;
            slider3.value =0;
            slider4.value =0;
            slider5.value = 0;
            slider6.value =0;
            slider7.value = 0;
            slider8.value =0;
            slider9.value =0;
            slider10.value =0;
            break;
        case 1:
            
            eqparametric1.gain = 7.9;
            eqparametric2.gain =4.8;
            eqparametric3.gain = -5.5;
            eqparametric4.gain = -7.9;
            eqparametric5.gain = -3.2;
            eqparametric6.gain = 3.9;
            eqparametric7.gain = 8.8;
            eqparametric8.gain = 11.1;
            eqparametric9.gain = 11.1;
            eqparametric10.gain = 11.1;
            
            slider1.value = 7.9;
            slider2.value = 4.8;
            slider3.value =-5.5;
            slider4.value =-7.9;
            slider5.value = -3.2;
            slider6.value =3.9;
            slider7.value = 8.8;
            slider8.value =11.1;
            slider9.value =11.1;
            slider10.value =11.1;
            
            break;
            
        case 2:
            eqparametric1.gain = -1.6;
            eqparametric2.gain =4.8;
            eqparametric3.gain = 7.1;
            eqparametric4.gain = 7.9;
            eqparametric5.gain = 5.5;
            eqparametric6.gain = 0;
            eqparametric7.gain = -2.4;
            eqparametric8.gain = -2.4;
            eqparametric9.gain = -1.6;
            eqparametric10.gain = -1.6;
            
            slider1.value = -1.6;
            slider2.value = 4.8;
            slider3.value =7.1;
            slider4.value =7.9;
            slider5.value = 5.5;
            slider6.value =0;
            slider7.value = -2.4;
            slider8.value =-2.4;
            slider9.value =-1.6;
            slider10.value =-1.6;
            break;
            
        case 3:
            eqparametric1.gain = 0;
            eqparametric2.gain =0;
            eqparametric3.gain = 0;
            eqparametric4.gain = 0;
            eqparametric5.gain = 0;
            eqparametric6.gain = 0;
            eqparametric7.gain = -7.1;
            eqparametric8.gain = -7.1;
            eqparametric9.gain = -7.1;
            eqparametric10.gain = -9.6;
            
            slider1.value = 0;
            slider2.value = 0;
            slider3.value =0;
            slider4.value =0;
            slider5.value = 0;
            slider6.value =0;
            slider7.value = -7.1;
            slider8.value =-7.1;
            slider9.value =-7.1;
            slider10.value =-9.6;
            break;
            
        case 4:
            
            eqparametric1.gain = 4.8;
            eqparametric2.gain = 1.6;
            eqparametric3.gain = 0;
            eqparametric4.gain = -2.4;
            eqparametric5.gain = 0;
            eqparametric6.gain = 3.9;
            eqparametric7.gain = 7.9;
            eqparametric8.gain = 9.6;
            eqparametric9.gain = 11.1;
            eqparametric10.gain = 11.9;
            
            slider1.value = 4.8;
            slider2.value = 1.6;
            slider3.value =0;
            slider4.value =-2.4;
            slider5.value = 0;
            slider6.value =3.9;
            slider7.value = 7.9;
            slider8.value =9.6;
            slider9.value =11.1;
            slider10.value =11.9;
            
            
            break;
        case 5:
            eqparametric1.gain = -4.8;
            eqparametric2.gain =0;
            eqparametric3.gain = 3.9;
            eqparametric4.gain = 5.5;
            eqparametric5.gain = 5.5;
            eqparametric6.gain = 5.5;
            eqparametric7.gain = 3.9;
            eqparametric8.gain = 2.4;
            eqparametric9.gain = 2.4;
            eqparametric10.gain = 2.4;
            
            slider1.value = -4.8;
            slider2.value = 0;
            slider3.value =3.9;
            slider4.value =5.5;
            slider5.value = 5.5;
            slider6.value =5.5;
            slider7.value = 3.9;
            slider8.value =2.4;
            slider9.value =2.4;
            slider10.value =2.4;
            break;
        case 6:
            eqparametric1.gain = 9.6;
            eqparametric2.gain =7.1;
            eqparametric3.gain = 2.4;
            eqparametric4.gain = 0;
            eqparametric5.gain = 0;
            eqparametric6.gain = -5.5;
            eqparametric7.gain = -7.1;
            eqparametric8.gain = -7.1;
            eqparametric9.gain = 0;
            eqparametric10.gain = 0;
            
            slider1.value = 9.6;
            slider2.value = 7.1;
            slider3.value =2.4;
            slider4.value =0;
            slider5.value = 0;
            slider6.value =-5.5;
            slider7.value = -7.1;
            slider8.value =-7.1;
            slider9.value =0;
            slider10.value =0;
            
            break;
        case 7:
            eqparametric1.gain = 3.9;
            eqparametric2.gain =3.9;
            eqparametric3.gain = 2.4;
            eqparametric4.gain = 0;
            eqparametric5.gain = -3.9;
            eqparametric6.gain = -5.5;
            eqparametric7.gain = -3.2;
            eqparametric8.gain = 0;
            eqparametric9.gain = 2.4;
            eqparametric10.gain = 8.8;
            
            slider1.value = 3.9;
            slider2.value = 3.9;
            slider3.value =2.4;
            slider4.value =0;
            slider5.value = -3.9;
            slider6.value =-5.5;
            slider7.value = -3.2;
            slider8.value =0;
            slider9.value =2.4;
            slider10.value =8.8;
            break;
        case  8:
            eqparametric1.gain = 4.8;
            eqparametric2.gain = 11.1;
            eqparametric3.gain = 5.5;
            eqparametric4.gain = -3.2;
            eqparametric5.gain = -2.4;
            eqparametric6.gain = 1.6;
            eqparametric7.gain = 4.8;
            eqparametric8.gain = 9.6;
            eqparametric9.gain = 12.8;
            eqparametric10.gain = 14.3;
            
            slider1.value = 4.8;
            slider2.value = 11.1;
            slider3.value =5.5;
            slider4.value =-3.2;
            slider5.value = -2.4;
            slider6.value =1.6;
            slider7.value = 4.8;
            slider8.value =9.6;
            slider9.value =12.8;
            slider10.value =14.3;
            
            break;
        case 9:
            eqparametric1.gain = 7.1;
            eqparametric2.gain =7.1;
            eqparametric3.gain = 0;
            eqparametric4.gain = 0;
            eqparametric5.gain = 0;
            eqparametric6.gain = 0;
            eqparametric7.gain = 0;
            eqparametric8.gain = 0;
            eqparametric9.gain = 7.1;
            eqparametric10.gain = 7.1;
            
            slider1.value = 7.1;
            slider2.value = 7.1;
            slider3.value =0;
            slider4.value =0;
            slider5.value = 0;
            slider6.value =0;
            slider7.value = 0;
            slider8.value =0;
            slider9.value =7.1;
            slider10.value =7.1;
            
            break;
        case 10:
            eqparametric1.gain = 0;
            eqparametric2.gain =0;
            eqparametric3.gain = 7.9;
            eqparametric4.gain = 5.5;
            eqparametric5.gain = 5.5;
            eqparametric6.gain = 5.5;
            eqparametric7.gain = 3.2;
            eqparametric8.gain = 0;
            eqparametric9.gain = 0;
            eqparametric10.gain = 0;
            
            slider1.value = 0;
            slider2.value = 0;
            slider3.value =7.9;
            slider4.value =5.5;
            slider5.value = 5.5;
            slider6.value =5.5;
            slider7.value = 3.2;
            slider8.value =0;
            slider9.value =0;
            slider10.value =0;
            break;
        case  11:
            eqparametric1.gain = 7.1;
            eqparametric2.gain =5.5;
            eqparametric3.gain = 0;
            eqparametric4.gain = -7.1;
            eqparametric5.gain = -4.8;
            eqparametric6.gain = 1.6;
            eqparametric7.gain = 7.9;
            eqparametric8.gain = 11.1;
            eqparametric9.gain = 11.9;
            eqparametric10.gain = 11.9;
            
            slider1.value = 7.1;
            slider2.value = 5.5;
            slider3.value =0;
            slider4.value =-7.1;
            slider5.value = -4.8;
            slider6.value =1.6;
            slider7.value = 7.9;
            slider8.value =11.1;
            slider9.value =11.9;
            slider10.value =11.9;
            
            break;
        case  12:

            eqparametric1.gain = -7.9;
            eqparametric2.gain =9.6;
            eqparametric3.gain = 9.6;
            eqparametric4.gain = 5.5;
            eqparametric5.gain = 1.6;
            eqparametric6.gain = -3.9;
            eqparametric7.gain = -7.9;
            eqparametric8.gain = -10.3;
            eqparametric9.gain = -11.1;
            eqparametric10.gain = -11.1;
            
            slider1.value = -7.9;
            slider2.value = 9.6;
            slider3.value =9.6;
            slider4.value =5.5;
            slider5.value = 1.6;
            slider6.value =-3.9;
            slider7.value = -7.9;
            slider8.value =-10.3;
            slider9.value =-11.1;
            slider10.value =-11.1;
            break;
        case 13:
            eqparametric1.gain = -9.6;
            eqparametric2.gain =-9.6;
            eqparametric3.gain = -9.6;
            eqparametric4.gain = -3.9;
            eqparametric5.gain = 2.4;
            eqparametric6.gain = 11.1;
            eqparametric7.gain = 15.9;
            eqparametric8.gain = 15.9;
            eqparametric9.gain = 15.9;
            eqparametric10.gain = 16.7;
            
            
            slider1.value = -9.6;
            slider2.value = -9.6;
            slider3.value =-9.6;
            slider4.value =-3.9;
            slider5.value = 2.4;
            slider6.value =11.1;
            slider7.value = 15.9;
            slider8.value =15.9;
            slider9.value =15.9;
            slider10.value =16.7;
            
        
            
            break;
        case 14:
            eqparametric1.gain = -2.4;
            eqparametric2.gain = -4.8;
            eqparametric3.gain = -3.9;
            eqparametric4.gain = 0;
            eqparametric5.gain = 3.9;
            eqparametric6.gain = 5.5;
            eqparametric7.gain = 8.8;
            eqparametric8.gain = 9.6;
            eqparametric9.gain = 11.1;
            eqparametric10.gain = 9.6;
            
            slider1.value = -2.4;
            slider2.value = -4.8;
            slider3.value =-3.9;
            slider4.value =0;
            slider5.value = 3.9;
            slider6.value =5.5;
            slider7.value = 8.8;
            slider8.value =9.6;
            slider9.value =11.1;
            slider10.value =9.6;
            
            
            
            break;
        case 15:
            eqparametric1.gain = 7.9;
            eqparametric2.gain = 5.5;
            eqparametric3.gain = 0;
            eqparametric4.gain = -5.5;
            eqparametric5.gain = -4.8;
            eqparametric6.gain = 0;
            eqparametric7.gain = 7.9;
            eqparametric8.gain = 9.6;
            eqparametric9.gain = 9.6;
            eqparametric10.gain = 8.8;
            
            
            slider1.value = 7.9;
            slider2.value = 5.5;
            slider3.value =0;
            slider4.value =-5.5;
            slider5.value = -4.8;
            slider6.value =0;
            slider7.value = 7.9;
            slider8.value =9.6;
            slider9.value =9.6;
            slider10.value =8.8;
            

            break;
        case 16:
            eqparametric1.gain = 10.3;
            eqparametric2.gain = 10.3;
            eqparametric3.gain = 5.5;
            eqparametric4.gain = 5.5;
            eqparametric5.gain = 0;
            eqparametric6.gain = -4.8;
            eqparametric7.gain = -4.8;
            eqparametric8.gain = -4.8;
            eqparametric9.gain = 0;
            eqparametric10.gain = 0;
            
            slider1.value = 10.3;
            slider2.value = 10.3;
            slider3.value =5.5;
            slider4.value =5.5;
            slider5.value = 0;
            slider6.value =-4.8;
            slider7.value = -4.8;
            slider8.value =-4.8;
            slider9.value =0;
            slider10.value =0;
            
            break;
        case 17:
            eqparametric1.gain = 0;
            eqparametric2.gain =0;
            eqparametric3.gain = 0;
            eqparametric4.gain = -5.5;
            eqparametric5.gain = 0;
            eqparametric6.gain = 6.4;
            eqparametric7.gain = 6.4;
            eqparametric8.gain = 0;
            eqparametric9.gain = 0;
            eqparametric10.gain = 0;
            
            slider1.value = 0;
            slider2.value = 0;
            slider3.value =0;
            slider4.value =-5.5;
            slider5.value = 0;
            slider6.value =6.4;
            slider7.value = 6.4;
            slider8.value =0;
            slider9.value =0;
            slider10.value =0;
            break;
            
            
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegate protocol

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.x < 0) {
        baseOffset = MAX(0, baseOffset - offsetStep);
    } else if (velocity.x > 0) {
        baseOffset = MIN(scrollView.contentSize.width - scrollView.bounds.size.width, baseOffset + offsetStep);
    }
#if 0
    dispatch_async(dispatch_get_main_queue(), ^{
        [scrollView setContentOffset:CGPointMake(baseOffset, 0) animated:YES];
    });
#else
    targetContentOffset->x = baseOffset;
#endif
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

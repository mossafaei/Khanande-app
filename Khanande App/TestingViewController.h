//
//  TestingViewController.h
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZAudio.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import "SettingViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <SWRevealViewController/SWRevealViewController.h>
@class AudioProcessor;
@interface TestingViewController : UIViewController <EZAudioPlayerDelegate,AVAudioRecorderDelegate,AVCaptureFileOutputRecordingDelegate,AVAudioSessionDelegate>{
    AVAudioRecorder*recorder;
    MPMoviePlayerController*mpc;
    UIImageView*imagecover;
    UIImageView*microred;
    UIImageView*loadmicro;
    NSTimer*timer;
    UILabel*label;
    NSUInteger min,sec;
    int endshomar;
    
    AVCaptureSession *session1;
    AVCaptureMovieFileOutput *movieFileOutput;
    UIView* frameForCapture;
    
    AVAudioPlayer *playerformicro;
    
}
@property (nonatomic, strong) EZAudioFile *audioFile;
@property (retain, nonatomic) AudioProcessor *audioProcessor;

@property (nonatomic, strong) EZAudioPlayer *player;

@property (nonatomic, strong) IBOutlet EZAudioPlotGL *audioPlot;
@end

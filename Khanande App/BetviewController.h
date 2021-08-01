//
//  BetviewController.h
//  Khanande
//
//  Created by Apple on 5/18/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "TestingViewController.h"
@interface BetviewController : UIViewController <AVCaptureFileOutputRecordingDelegate>{
    UIImageView* imagecover;
    AVCaptureSession *session;
    AVCaptureMovieFileOutput *movieFileOutput;
    UIButton *start;
    UISwitch*videoswitch;
    UISwitch*voicetype;
    
    IBOutlet UIView* frameForCapture;
    
}

@end

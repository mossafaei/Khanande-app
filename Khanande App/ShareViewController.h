//
//  ShareViewController.h
//  Khanande App
//
//  Created by Apple on 9/10/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <SWRevealViewController/SWRevealViewController.h>
@interface ShareViewController : UIViewController <AVAudioPlayerDelegate>{
    AVAudioPlayer*player;
    UIButton*playpause;
    UIButton*save;
     NSUInteger nobat;
    MPMoviePlayerController*mpc;
}

@end

//
//  SettingViewController.h
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FirstTableViewController.h"
#import "ShareViewController.h"
#import "MyCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <TheAmazingAudioEngine/TheAmazingAudioEngine.h>
#import <TheAmazingAudioEngine/AEParametricEqFilter.h>
#import <TheAmazingAudioEngine/AEReverbFilter.h>
#import <SWRevealViewController/SWRevealViewController.h>
@interface SettingViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    UISlider*musicvol;
    UISlider*singervol;
    UIButton*exportbutton;
    UIAlertView*alert1;
    UILabel*singervollabel;
    UILabel*musicvollabel;
    UIImageView*imagecover;
    NSMutableData*datawithout;
    UISwitch*echoswitch;
    UILabel*labelechoswitch;
    UIButton*voiceimprovbutton;
    NSURL *myURL10;
    NSURL *url5;
    NSUInteger countalert;
    NSString *stralert;
    ///EQ
    UISlider*slider1;
    UISlider*slider2;
    UISlider*slider3;
    UISlider*slider4;
    UISlider*slider5;
    UISlider*slider6;
    UISlider*slider7;
    UISlider*slider8;
    UISlider*slider9;
    UISlider*slider10;
    NSString *filePath10;
    

    UICollectionView*collectionView;
    NSString *exportPath1;

    
    
    AEAudioController *audiocontroller;
    AEAudioController *audiocontrollerexport;
    AEAudioFilePlayer *musicplayer;
    AEAudioFilePlayer *singerplayer;
    AEAudioFilePlayer *musicplayerexport;
    AEAudioFilePlayer *singerplayerexport;
    AEParametricEqFilter *eqparametric1;
    AEParametricEqFilter *eqparametric2;
    AEParametricEqFilter *eqparametric3;
    AEParametricEqFilter *eqparametric4;
    AEParametricEqFilter *eqparametric5;
    AEParametricEqFilter *eqparametric6;
    AEParametricEqFilter *eqparametric7;
    AEParametricEqFilter *eqparametric8;
    AEParametricEqFilter *eqparametric9;
    AEParametricEqFilter *eqparametric10;
    AEReverbFilter *reverbfilter;
    
    AEParametricEqFilter *eqparametric1export;
    AEParametricEqFilter *eqparametric2export;
    AEParametricEqFilter *eqparametric3export;
    AEParametricEqFilter *eqparametric4export;
    AEParametricEqFilter *eqparametric5export;
    AEParametricEqFilter *eqparametric6export;
    AEParametricEqFilter *eqparametric7export;
    AEParametricEqFilter *eqparametric8export;
    AEParametricEqFilter *eqparametric9export;
    AEParametricEqFilter *eqparametric10export;
    AEReverbFilter *reverbfilterexport;
    
    UISlider *drywetslider;
    NSArray *centerferearray;
}

@property(nonatomic, strong) AVAsset *videoAsset;


@end

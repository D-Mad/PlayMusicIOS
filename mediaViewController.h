//
//  mediaViewController.h
//  Mu
//
//  Created by PROIOS on 7/20/14.
//  Copyright (c) 2014 PROIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface mediaViewController : UIViewController<AVAudioPlayerDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *deviceCurrentTimeLabel;
//property (retain, nonatomic) IBOutlet UILabel *durationLabel;
//@property (weak, nonatomic) IBOutlet UILabel *numberOfChannelsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *playingLabel;

@property (retain, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@property (retain, nonatomic) IBOutlet UISlider *currentTimeSlider;


@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;




- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;

- (IBAction)currentTimeSliderValueChanged:(id)sender;
- (IBAction)currentTimeSliderTouchUpInside:(id)sender;




@end

//
//  mediaViewController.m
//  Mu
//
//  Created by PROIOS on 7/20/14.
//  Copyright (c) 2014 PROIOS. All rights reserved.
//

#import "mediaViewController.h"

@interface mediaViewController ()

@property (nonatomic, strong) AVAudioPlayer* player;
@property (nonatomic, strong) NSTimer* timer;

- (void)updateDisplay;
- (void)updateSliderLabels;

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag;
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player
                                 error:(NSError *)error;

@end


@implementation mediaViewController
@synthesize elapsedTimeLabel = mElapsedTimeLabel;
@synthesize remainingTimeLabel = mRemainingTimeLabel;
@synthesize currentTimeSlider = mCurrentTimeSlider;
@synthesize playButton = mPlayingButton;
@synthesize pauseButton = mPauseButton;
@synthesize stopButton = mStopButton;





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"KissTheRain-Yurima_4jy3" withExtension:@"mp3"];
    NSAssert(url, @"URL is valid.");
    
    NSError* error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    
    if(!self.player)
    {
        NSLog(@"Error creating player: %@", error);
    }
    self.player.delegate = self;
    [self.player prepareToPlay];
    self.currentTimeSlider.minimumValue = 0.0f;
    self.currentTimeSlider.maximumValue = self.player.duration;
    
    
    
}



-(void)viewDidUnload {
    
    [self setPauseButton:nil];
    [self setPlayButton:nil];
    [self setStopButton:nil];
    [self setElapsedTimeLabel:nil];
    [self setRemainingTimeLabel:nil];
    [self setCurrentTimeSlider:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



-(void)loadView
{   //Display button play ,stop ,pause and label elapsedTime,remaingtime
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] ;
    self.view.backgroundColor = [UIColor grayColor];
    self.playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [self.playButton  setTitle:@"Play" forState:UIControlStateNormal];
    self.playButton.frame = CGRectMake(100, 55, 40, 30);
    [self.view addSubview:self.playButton];
    [self.playButton addTarget:self action:@selector(play:)forControlEvents:UIControlEventTouchUpInside];
    
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    self.pauseButton.frame = CGRectMake(150, 55, 50, 30);
    [self.view addSubview:self.pauseButton];
    [self.playButton addTarget:self action:@selector(pause:)forControlEvents:UIControlEventTouchUpInside];
    
    self.stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    self.stopButton.frame = CGRectMake(210, 55, 60, 30);
    [self.view addSubview:self.stopButton];
    [self.stopButton addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    
    self.elapsedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 20, 30)];
    self.elapsedTimeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.elapsedTimeLabel];
    
    self.remainingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(265, 200, 50, 30)];
    self.remainingTimeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.remainingTimeLabel] ;
    
    
    //Do dai bai hat slider 1 & 2
    
    CGRect frame = CGRectMake(40.0,200, 230, 10.0);
    self.currentTimeSlider = [[UISlider alloc] initWithFrame:frame];
    // [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.currentTimeSlider setBackgroundColor:[UIColor clearColor]];
    self.currentTimeSlider.minimumValue = 0.0;
    self.currentTimeSlider.maximumValue = 50.0;
    self.currentTimeSlider.continuous = YES;
    self.currentTimeSlider.value = 25.0;
    [self.view addSubview:self.currentTimeSlider];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)play:(id)sender {
    
    NSLog(@"Play");
    [self.player play];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    //[self viewmusic2];
    
}

- (IBAction)pause:(id)sender {
    
}

- (IBAction)stop:(id)sender {
    
}

- (IBAction)currentTimeSliderValueChanged:(id)sender {
}

- (IBAction)currentTimeSliderTouchUpInside:(id)sender {
}

- (void)timerFired:(NSTimer*)timer
{
    [self updateDisplay];
}

- (void)updateDisplay
{
    NSTimeInterval currentTime = self.player.currentTime;
    self.currentTimeSlider.value = currentTime;
    [self updateSliderLabels];
    
    
    
    
}


- (void)updateSliderLabels
{
    NSTimeInterval currentTime = self.currentTimeSlider.value;
    NSString* currentTimeString = [NSString stringWithFormat:@"%.02f", currentTime];
    self.elapsedTimeLabel.text =  currentTimeString;
    self.remainingTimeLabel.text = [NSString stringWithFormat:@"%.02f", self.player.duration - currentTime];
}


- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self updateDisplay];
}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"%s successfully=%@", __PRETTY_FUNCTION__, flag ? @"YES"  : @"NO");
    [self stopTimer];
    [self updateDisplay];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
    [self stopTimer];
    [self updateDisplay];
}


@end

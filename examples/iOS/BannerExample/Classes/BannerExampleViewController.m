//
//  BannerExampleViewController.m
//  BannerExample
//
//  Copyright 2011 Google Inc. All rights reserved.
//

#import "BannerExampleViewController.h"
#import "GADBannerView.h"
#import "GADRequest.h"
#import "SampleConstants.h"

@implementation BannerExampleViewController

@synthesize adBanner = adBanner_;

#pragma mark init/dealloc

// Implement viewDidLoad to do additional setup after loading the view,
// typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];

  // Note that the GADBannerView checks its frame size to determine what size
  // creative to request.

  //Initialize the banner off the screen so that it animates up when displaying
  self.adBanner = [[[GADBannerView alloc] initWithFrame:CGRectMake(0.0,
                                                                   self.view.frame.size.height,
                                                                   GAD_SIZE_320x50.width,
                                                                   GAD_SIZE_320x50.height)] autorelease];
  // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID
  // before compiling.
  self.adBanner.adUnitID = kSampleAdUnitID;
  self.adBanner.delegate = self;
  [self.adBanner setRootViewController:self];
  [self.view addSubview:self.adBanner];
  [self.adBanner loadRequest:[self createRequest]];
  
}

- (void)dealloc {
  self.adBanner.delegate = nil;
  [adBanner_ release];
  [super dealloc];
}

#pragma mark GADRequest generation

// Here we're creating a simple GADRequest and whitelisting the simulator
// and two devices for test ads. You should request test ads during development
// to avoid generating invalid impressions and clicks.
- (GADRequest *)createRequest {
  GADRequest *request = [GADRequest request];
  
  //Make the request for a test ad
  request.testDevices = [NSArray arrayWithObjects:
                         GAD_SIMULATOR_ID,                               // Simulator
                         nil];

  return request;
}

#pragma mark GADBannerViewDelegate impl

// Since we've received an ad, let's go ahead and set the frame to display it.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
  NSLog(@"Received ad");

  [UIView animateWithDuration:1.0 animations:^ {
    adView.frame = CGRectMake(0.0,
                              self.view.frame.size.height -
                              adView.frame.size.height,
                              adView.frame.size.width,
                              adView.frame.size.height);
  
  }];
}

- (void)adView:(GADBannerView *)view
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

@end

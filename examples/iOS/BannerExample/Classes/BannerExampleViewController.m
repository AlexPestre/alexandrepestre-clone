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
  CGRect frame = CGRectMake(0, 410, 320, 50);
  self.adBanner = [[[GADBannerView alloc] initWithFrame:frame] autorelease];
  // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID
  // before compiling.
  self.adBanner.adUnitID = kSampleAdUnitID;
  self.adBanner.delegate = self;
  [self.adBanner setRootViewController:self];
  [self.adBanner loadRequest:[self createRequest]];
}

- (void)dealloc {
  self.adBanner.delegate = nil;
  self.adBanner = nil;
  [super dealloc];
}

#pragma mark GADRequest generation

// Here we're creating a simple GADRequest and whitelisting the simulator
// and two devices for test ads. You should request test ads during development
// to avoid generating invalid impressions and clicks.
- (GADRequest *)createRequest {
  GADRequest *request = [GADRequest request];
  
  request.testDevices = [NSArray arrayWithObjects:
                         GAD_SIMULATOR_ID,                               // Simulator
                         @"28ab37c3902621dd572509110745071f0101b124",    // Test iPhone 3G 3.0.1
                         @"8cf09e81ef3ec5418c3450f7954e0e95db8ab200",    // Test iPod 4.3.1
                         nil];

  return request;
}

#pragma mark GADBannerViewDelegate impl

// Since we've received an ad, let's go ahead and add it to the view.
- (void)adViewDidReceiveAd:(GADBannerView *)view {
  NSLog(@"Received ad");
  [self.view addSubview:view];
}

- (void)adView:(GADBannerView *)view
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"failed to receive ad with error: %@", [error localizedFailureReason]);
}

@end

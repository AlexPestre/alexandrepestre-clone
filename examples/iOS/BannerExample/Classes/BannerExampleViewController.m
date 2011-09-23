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

// Here we're creating a simple GADRequest and adding a few separate keywords to
// it.  Note that there's a bevy of additional options we could take advantage
// of, such as location and demographic targeting.
- (GADRequest *)createRequest {
  GADRequest *request = [GADRequest request];
  [request addKeyword:@"taxi service"];
  [request addKeyword:@"airport"];
  
  request.additionalParameters = [NSMutableDictionary 
                                  dictionaryWithObject:@"on" forKey:@"adtest"];
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

// MainController.m
// Copyright 2011 Google Inc. All rights reserved.

#import "InterstitialExampleAppDelegate.h"
#import "MainController.h"

@implementation MainController

@synthesize interstitialButton = interstitialButton_;

- (void)dealloc {
  interstitial_.delegate = nil;
  [interstitial_ release];

  [super dealloc];
}

- (void)interstitial:(GADInterstitial *)interstitial
          didFailToReceiveAdWithError:(GADRequestError *)error {
  UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:@"GADRequestError"
                        message:[error localizedDescription]
                        delegate:nil cancelButtonTitle:@"Drat"
                        otherButtonTitles:nil];
  [alert show];
  [alert autorelease];

  interstitialButton_.enabled = YES;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
  [interstitial presentFromRootViewController:self];
  interstitialButton_.enabled = YES;
}

- (IBAction)showInterstitial:(id)sender {
  if (!interstitial_) {
    interstitial_ = [[GADInterstitial alloc] init];

    interstitial_.delegate = self;
    // Note: Edit InterstitialExampleAppDelegate.m to update 
    // INTERSTITIAL_AD_UNIT_ID with your interstitial ad unit id.
    interstitial_.adUnitID = ((InterstitialExampleAppDelegate *)
                              [UIApplication sharedApplication].delegate).
                                interstitialAdUnitID;
  }
    
  GADRequest *request = [GADRequest request];
    
  // Here we're setting test mode for the simulator.
  request.testDevices = [NSArray arrayWithObjects:
      GAD_SIMULATOR_ID, // Simulator
      nil];
    
  [interstitial_ loadRequest: request];

  interstitialButton_.enabled = NO;
}

@end

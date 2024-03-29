// MainController.m
// Copyright 2011 Google Inc. All rights reserved.

#import "InterstitialExampleAppDelegate.h"
#import "MainController.h"

@implementation MainController

@synthesize interstitialButton = interstitialButton_;
@synthesize interstitial = interstitial_;

- (void)dealloc {
  interstitial_.delegate = nil;
  [interstitial_ release];
  [interstitialButton_ release];
  [super dealloc];
}

- (void)interstitial:(GADInterstitial *)interstitial
    didFailToReceiveAdWithError:(GADRequestError *)error {
  // Alert the error.
  UIAlertView *alert = [[[UIAlertView alloc]
                        initWithTitle:@"GADRequestError"
                        message:[error localizedDescription]
                        delegate:nil cancelButtonTitle:@"Drat"
                        otherButtonTitles:nil] autorelease];
  [alert show];

  interstitialButton_.enabled = YES;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
  [interstitial presentFromRootViewController:self];
  interstitialButton_.enabled = YES;
}


- (IBAction)showInterstitial:(id)sender {
  // Create a new GADInterstitial each time.  A GADInterstitial
  // will only show one request in its lifetime. The property will release the
  // old one and set the new one.
  self.interstitial = [[[GADInterstitial alloc] init] autorelease];

  self.interstitial.delegate = self;
  
  // Note: Edit InterstitialExampleAppDelegate.m to update 
  // INTERSTITIAL_AD_UNIT_ID with your interstitial ad unit id.
  self.interstitial.adUnitID = ((InterstitialExampleAppDelegate *)
                            [UIApplication sharedApplication].delegate).
                            interstitialAdUnitID;
    
  GADRequest *request = [GADRequest request];
    
  // Here we're setting test mode for the simulator.
  request.testDevices = [NSArray arrayWithObjects:
      GAD_SIMULATOR_ID, // Simulator
      nil];
    
  [self.interstitial loadRequest: request];

  interstitialButton_.enabled = NO;
}

@end

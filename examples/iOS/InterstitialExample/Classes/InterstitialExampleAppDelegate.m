// InterstitialExampleAppDelegate.m
// Copyright 2011 Google Inc. All rights reserved.

#import "InterstitialExampleAppDelegate.h"

#define INTERSTITIAL_AD_UNIT_ID @"MY_INTERSTITIAL_AD_UNIT_ID"

@implementation InterstitialExampleAppDelegate

@synthesize mainController = mainController_;
@synthesize window = window_;

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self.window addSubview:self.mainController.view];
  [self.window makeKeyAndVisible];

  // This is an example of how to create a splash interstitial.
  splashInterstitial_ = [[GADInterstitial alloc] init];

  splashInterstitial_.adUnitID = self.interstitialAdUnitID;
  splashInterstitial_.delegate = self;

  [splashInterstitial_ loadAndDisplayRequest:[GADRequest request]
                       usingWindow:self.window
                       initialImage:[UIImage imageNamed:@"InitialImage"]];
  return YES;
}

- (void)dealloc {
  splashInterstitial_.delegate = nil;

  [splashInterstitial_ release];
  [window_ release];
  [mainController_ release];

  [super dealloc];
}

// Returns the interstitial ad unit ID. In a real-world app each intersitial
// placement would have a distinct unit ID.
- (NSString *)interstitialAdUnitID {
  return INTERSTITIAL_AD_UNIT_ID;
}

@end

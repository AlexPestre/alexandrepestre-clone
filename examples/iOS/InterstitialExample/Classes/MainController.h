// MainController.h
// Copyright 2011 Google Inc. All rights reserved.

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"

@interface MainController : UIViewController <GADInterstitialDelegate> {
  UIButton *interstitialButton_;
  GADInterstitial *interstitial_;
}

@property (nonatomic, retain) IBOutlet UIButton *interstitialButton;

- (IBAction)showInterstitial:(id)sender;

@end

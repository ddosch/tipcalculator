//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Dan Dosch on 1/6/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tipPercent;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipTab;

- (IBAction)onTap:(id)sender;
- (IBAction)valueChanged:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self saveValues];
}

- (IBAction)valueChanged:(id)sender {
    [self getValues];
}

- (void)saveValues {
    float tip = [self.tipPercent.text floatValue];
    
    NSInteger selected = self.tipTab.selectedSegmentIndex;
    NSLog(@"Selected is %d", selected);
    NSLog(@"Setting tip amount to %0.2f", tip);
    NSArray *tipArrayKeys = @[@"firstTipKey", @"secondTipKey", @"thirdTipKey"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:tip forKey:tipArrayKeys[selected]];
    [defaults synchronize];
}

- (void)getValues {
    NSArray *tipArrayKeys = @[@"firstTipKey", @"secondTipKey", @"thirdTipKey"];
    
    NSInteger selected = self.tipTab.selectedSegmentIndex;
    NSLog(@"Selected is %d", selected);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    float tip = [defaults floatForKey:tipArrayKeys[selected]];
    NSLog(@"Got tip amount to %0.2f", tip);
    self.tipPercent.text = [NSString stringWithFormat:@"%0.1f", tip];
}

@end

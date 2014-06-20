//
//  ViewController.m
//  ServoControl_PTDBean
//
//  Created by Ben Harraway on 18/06/2014.
//  Copyright (c) 2014 Gourmet Pixel Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    btnScan = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 60, 200, 60)];
    [btnScan setBackgroundColor:[UIColor darkGrayColor]];
    [btnScan addTarget:self action:@selector(startScanning) forControlEvents:UIControlEventTouchUpInside];
    [btnScan setTitle:@"Start Scanning" forState:UIControlStateNormal];
    [self.view addSubview:btnScan];
    
    UISlider *aSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-20, 20)];
    [aSlider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:aSlider];
    
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 30)];
    [statusLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:statusLabel];
    
    self.beanManager = [[PTDBeanManager alloc] initWithDelegate:self];
    self.bean = nil;

}

- (void) startScanning {
    if (self.bean.state == BeanState_ConnectedAndValidated) {
        NSError *err;
        [self.beanManager disconnectBean:self.bean error:&err];
        if (err) statusLabel.text = [err localizedDescription];
        [btnScan setTitle:@"Start Scanning" forState:UIControlStateNormal];
        
    } else {
        if(self.beanManager.state == BeanManagerState_PoweredOn) {
            NSError *err;
            [self.beanManager startScanningForBeans_error:&err];
            statusLabel.text = @"Scanning";
            if (err) {
                statusLabel.text = [err localizedDescription];
            }
        } else {
            statusLabel.text = @"Bean Manager not powered on";
        }
    }
}

- (void) sliderMoved:(UISlider *)sender {
    float max = 180;                                    // Max position of servo
    unsigned int sendData = floor(sender.value*max);    // Convert slider value to servo rotation degrees
    
    if (self.bean) {
        NSMutableData *data = [NSMutableData dataWithBytes:&sendData length:sizeof(sendData)];
        
        // Cancel any pending data sends
        [NSObject cancelPreviousPerformRequestsWithTarget:self];

        // We send the data after 0.3 seconds to avoid the quick movement of the slider backing up send commands
        [self performSelector:@selector(sendDataToBean:) withObject:data afterDelay:0.3];
    }
}

- (void) sendDataToBean:(NSMutableData *)sendData {
    [self.bean setScratchNumber:1 withValue:sendData];
    // Uncomment this line to get feedback from the bean, to make sure scratch data is OK
//    [self.bean readScratchBank:1];
}

// check the delegate value
-(void)bean:(PTDBean *)bean didUpdateScratchNumber:(NSNumber *)number withValue:(NSData *)data {
    unsigned int z;
    [data getBytes:&z length:sizeof(unsigned int)];
    NSLog(@"Bean Scratch is: %d", z);
}

// bean discovered
- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)aBean error:(NSError*)error{
    if (error) {
        statusLabel.text = [error localizedDescription];
        return;
    }
    statusLabel.text = [NSString stringWithFormat:@"Bean found: %@",[aBean name]];
    [self.beanManager connectToBean:aBean error:nil];
    
    
}
// bean connected
- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {
        statusLabel.text = [error localizedDescription];
        return;
    }
    // do stuff with your bean
    statusLabel.text = @"Bean connected!";
    self.bean = bean;
    self.bean.delegate = self;

    [btnScan setTitle:@"Disconnect" forState:UIControlStateNormal];
    
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDisconnectBean:(PTDBean*)bean error:(NSError*)error {
    statusLabel.text = @"Bean disconnected.";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

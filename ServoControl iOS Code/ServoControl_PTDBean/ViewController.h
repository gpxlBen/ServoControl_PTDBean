//
//  ViewController.h
//  ServoControl_PTDBean
//
//  Created by Ben Harraway on 18/06/2014.
//  Copyright (c) 2014 Gourmet Pixel Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTDBean.h"
#import "PTDBeanManager.h"
#import "PTDBeanRadioConfig.h"

@interface ViewController : UIViewController <PTDBeanDelegate, PTDBeanManagerDelegate> {
    UILabel *statusLabel;
    UIButton *btnScan;
}

@property (nonatomic, retain) PTDBean *bean;
@property (nonatomic, retain) PTDBeanManager *beanManager;

@end

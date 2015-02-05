//
//  ViewController.h
//  drawOnPhotos
//
//  Created by Quintin Davis on 1/8/14.
//  Copyright (c) 2014 KAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    CGPoint lastPoint;
    CGPoint moveBackTo;
    CGPoint currentPoint;
    CGPoint location;
    NSDate *lastClick;
    BOOL mouseSwiped;
    UIImageView *drawImage;
    UIImageView *frontImage;
}
@property (strong, nonatomic) IBOutlet UISlider *redSlider;
@property (strong, nonatomic) IBOutlet UISlider *greenSlider;
@property (strong, nonatomic) IBOutlet UISlider *blueSlider;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

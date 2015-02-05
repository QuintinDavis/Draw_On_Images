//
//  ViewController.m
//  drawOnPhotos
//
//  Created by Quintin Davis on 1/8/14.
//  Copyright (c) 2014 KAPP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	drawImage.image = [defaults objectForKey:@"drawImageKey"];
	drawImage = [[UIImageView alloc] initWithImage:nil];
	drawImage.frame = self.view.frame;
	[self.view addSubview:drawImage];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.imageView.image==nil){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        imagePickerController.delegate = self;
//        imagePickerController.delegate = self;
        //    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:NO completion:nil];
    }
    else{
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	
	if ([touch tapCount] == 2) {
        drawImage.image = nil;
	}
	
	location = [touch locationInView:touch.view];
	lastClick = [NSDate date];
    lastPoint = [touch locationInView:self.view];
    lastPoint.y -= 0;
    
	[super touchesBegan: touches withEvent: event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];
	currentPoint = [touch locationInView:self.view];
	
    UIGraphicsBeginImageContext(CGSizeMake(320,450));
    [drawImage.image drawInRect:CGRectMake(0, 0, 320, 450)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.redSlider.value, self.greenSlider.value, self.blueSlider.value, 1);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    [drawImage setFrame:CGRectMake(0, 0, 320, 450)];
    //    [drawImage setFrame:CGRectMake(0, 0, 320, 568)];
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
	
	[self.view addSubview:drawImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

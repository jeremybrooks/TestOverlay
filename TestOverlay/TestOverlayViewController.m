//
//  TestOverlayViewController.m
//  TestOverlay
//
//  Created by Jeremy Brooks on 5/27/11.
//  Copyright 2011 Jeremy Brooks. All rights reserved.
//

#import "TestOverlayViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

#import "UIImage+Resize.h"

@implementation TestOverlayViewController
@synthesize overlayImage;

- (void)openCamera
{
    // make sure this device has a camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        picker.showsCameraControls = YES;
        
                
        
        picker.delegate = self;
        [self presentModalViewController:picker
                                animated:YES];
        
        // set up the overlay if user wants it
        if (self.overlayImage != nil) {
            
            /*
             This seems like it should work. But it does not.
             
             CGRect screenRect = [[UIScreen mainScreen] bounds];
             UIImageView *overlay = [[UIImageView alloc] initWithImage:self.overlayImage];
             */
            
            // Overlay view will be the size of the screen
            UIImageView *overlay = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            // with an image sized to fit in the viewfinder window
            // (Resize using Trevor Harmon's UIImage+ categories)
            overlay.image = 
            [self.overlayImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                    bounds:CGSizeMake(320, 430) 
                                       interpolationQuality:kCGInterpolationDefault];
            
            // tell the view to put the image at the top, and make it transparent
            overlay.contentMode = UIViewContentModeTop;            
            overlay.alpha = 0.5f;
            
            picker.cameraOverlayView = overlay;
            
            [overlay release];      
        }

        [picker release];
        
    } else {
        [[[[UIAlertView alloc] initWithTitle:@"Camera Unavailable" 
                                     message:@"The camera is unavailable on this device. Add some images from your photo library." 
                                    delegate:nil 
                           cancelButtonTitle:@"OK" 
                           otherButtonTitles:nil] autorelease]show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    self.overlayImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self openCamera];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    [self openCamera];
}

- (void)dealloc
{
    [overlayImage release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self openCamera];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

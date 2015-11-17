//
//  ViewController.m
//  Exercise 2
//
//  Created by Mike on 2/10/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "MainViewController.h"
#import "DotView.h"

@interface MainViewController ()
@property (nonatomic, strong) IBOutlet UIButton *goButton;
@property (nonatomic, strong) IBOutlet UITextField *rowsTextField;
@property (nonatomic, strong) IBOutlet UITextField *colsTextField;
@property (nonatomic, strong) IBOutlet DotView *dotsView;
@property (nonatomic, strong) NSMutableArray *selectedColors;
@property (nonatomic, strong) NSNumberFormatter *nf;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _selectedColors = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(NSNumberFormatter *)nf
{
    if(!_nf)
    {
        _nf = [[NSNumberFormatter alloc] init];
    }
    return _nf;
}


#pragma mark - Actions
-(IBAction)colorTapped:(UIButton *)sender
{
    [_dotsView clearDots];
    
    sender.selected = !sender.selected;
    
    if(sender.selected)
    {
        sender.layer.borderColor = [UIColor colorWithWhite:.5 alpha:1.0].CGColor;
        sender.layer.borderWidth = 5;
        [_selectedColors addObject:sender.backgroundColor];
    }
    else
    {
        sender.layer.borderWidth = 0;
        [_selectedColors removeObject:sender.backgroundColor];
    }
}

-(IBAction)goTapped:(id)sender
{
    [self.view endEditing:YES];
    
    if([self readyToDraw])
    {
        _dotsView.rows = [NSNumber numberWithInteger:_rowsTextField.text.integerValue];
        _dotsView.coloumns = [NSNumber numberWithInteger:_colsTextField.text.integerValue];
        _dotsView.colors = _selectedColors;
        [_dotsView setNeedsDisplay];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"There is some information missing. Please check all fields and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(IBAction)saveImage:(id)sender
{
    UIImage *image = [_dotsView imageRepresentation];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(BOOL)readyToDraw
{
    BOOL ready = YES;
    if(_selectedColors.count <= 0) ready = NO;
    if(![self.nf numberFromString:_rowsTextField.text]) ready = NO;
    if(![self.nf numberFromString:_colsTextField.text]) ready = NO;
    return ready;
}

#pragma mark - Image Saving
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alertView;
    
    if(error)
    {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"There was an error saving the image. Please check your settings and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
    }
    else
    {
        alertView = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image succesfully saved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    }
    
    [alertView show];
}

#pragma mark - UITextField Delegate Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_dotsView clearDots];
}

@end

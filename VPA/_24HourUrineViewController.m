//
//  _24HourUrineViewController.m
//  VPA
//
//  Created by Brandon Koenning on 10/11/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "_24HourUrineViewController.h"

@interface _24HourUrineViewController (){
    NSMutableArray *enabledViews;
    UITapGestureRecognizer *recognizer;
}

@end

@implementation _24HourUrineViewController



@synthesize detailItem;


-(void)setDetailItem: (_24HourUrineCollection*) newDetailItem
{
    if (newDetailItem != nil && [self detailItem] != newDetailItem){
        detailItem = newDetailItem;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    enabledViews = [NSMutableArray arrayWithObjects:[self segUCr], [self segScr], [self segUrineVolume], [self urineCrText], [self serumCrText], [self urineVolumeText],nil];
    [self configureView];
    
    recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
   // NSLog(@"%@", [[[self detailItem]urineCr]valueAsString]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureView
{
    if ([[self detailItem]isSet]){
        [[self urineCrText]setText:[[[self detailItem]urineCr]valueAsString]];
        [[self serumCrText] setText:[[[self detailItem]serumCr]valueAsString]];
        [[self urineVolumeText] setText:[[[self detailItem]urineVolume]valueAsString]];
        if ([[[self detailItem]urineVolume]unit] == L){
            [[self segUrineVolume]setSelectedSegmentIndex:1];
        }
        else [[self segUrineVolume]setSelectedSegmentIndex:0];
        
        if ([[[self detailItem]serumCr]units] == MG_PER_DECILITER){
            [[self segScr]setSelectedSegmentIndex:0];
        }
        else{
            [[self segScr] setSelectedSegmentIndex:1];
        }
        if ([[[self detailItem]urineCr]units] == MILLIGRAMS_PER_DECILITER){
            [[self segUCr]setSelectedSegmentIndex:0];
        }
        else{
            [[self segUCr]setSelectedSegmentIndex:1];
        }
        
        [[self lockButton]setTitle:@"Unlock Information" forState:UIControlStateNormal];
        
        for (UIControl *con in enabledViews){
            [con setEnabled:NO];
        }
    }

}

-(void)validateAndLockInformation:(id)sender
{
    NSRegularExpression *creatinineReg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{1,3}(\\.\\d{1,5}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
   // NSRegularExpression *integerReg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{1,3}$" options:NSRegularExpressionCaseInsensitive error:nil];
    //NSTextCheckingResult *weightMatch = [decimalReg firstMatchInString:[self.textFieldWeight text] options:0 range:NSMakeRange(0, [[self.textFieldWeight text]length])];
   NSTextCheckingResult *serumCreatinineMatch = [creatinineReg firstMatchInString:[self.serumCrText text] options:0 range:NSMakeRange(0, [[self.serumCrText text]length])];
    //NSTextCheckingResult *ageMatch = [integerReg firstMatchInString:[self.textFieldAge text] options:0 range:NSMakeRange(0, [[self.textFieldAge text]length])];
    NSTextCheckingResult *urineCreatinineMatch = [creatinineReg firstMatchInString:[self.urineCrText text] options:0 range:NSMakeRange(0, [[self.urineCrText text]length])];
    
    NSRegularExpression *urineVolumeReg = [NSRegularExpression regularExpressionWithPattern:@"^\\d{1,5}(\\.\\d{1,5}?)?$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSTextCheckingResult *urineVolumeMatch = [urineVolumeReg firstMatchInString:[self.urineVolumeText text] options:0 range:NSMakeRange(0, [[self.urineVolumeText text]length])];
    
    BOOL isSerumCreatinineMatched = serumCreatinineMatch != nil;
    BOOL isUrineVolumeMatched = urineVolumeMatch != nil;
    BOOL isUrineCreatinineMatched = urineCreatinineMatch != nil;
    
    if ([[[[self lockButton]titleLabel]text]isEqualToString:@"Unlock Information"]){
        for (UIControl *con in enabledViews){
            [con setEnabled: YES];
        }
        
        [[self lockButton]setTitle:@"Lock Information" forState:UIControlStateNormal];
        [[self detailItem]setIsSet:NO];
        [[self detailItem]postDidChangeNotification];
    }
    else if (!isSerumCreatinineMatched){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for serum creatinine" message:@"Re-enter serum creatinine.  Be sure to enter a leading zero for decimal values less than 1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (!isUrineCreatinineMatched){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for urine creatinine" message:@"Re-enter urine creatinine.  Be sure to enter a leading zero for decimal values less than 1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (!isUrineVolumeMatched){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid entry for urine volume" message:@"Re-enter urine volume.  Be sure to enter a leading zero for decimal values less than 1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[self segUrineVolume]selectedSegmentIndex]== UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for urine volume units" message:@"Select a unit of measure for urine volume." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[self segScr]selectedSegmentIndex]== UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for serum creatinine concentration units" message:@"Select a unit of measure for serum creatinine." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[self segUCr]selectedSegmentIndex]== UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for urine creatinine concentration units" message:@"Select a unit of measure for urine creatinine." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([[self segUrineVolume]selectedSegmentIndex]== UISegmentedControlNoSegment){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing selected for urine volume units of measure" message:@"Select a unit of measure for urine volume." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (([[[self urineVolumeText]text]floatValue] < 0.6 || [[[self urineVolumeText]text]floatValue] > 8) && [[self segUrineVolume]selectedSegmentIndex] ==1 ){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for urine volume" message:@"Urine volume must be between 0.6 and 8 liters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (([[[self urineVolumeText]text]floatValue] < 600 || [[[self urineVolumeText]text]floatValue] > 8000) && [[self segUrineVolume]selectedSegmentIndex] == 0 ){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for urine volume" message:@"Urine volume must be between 600 and 8000 milliliters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (([[[self serumCrText]text]floatValue] < 0.3 || [[[self serumCrText]text]floatValue] > 5.0) && [[self segScr]selectedSegmentIndex] == 0 ){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for serum creatinine" message:@"Serum creatinine must be between 0.3 and 5.0 milligrams/deciliter" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (([[[self serumCrText]text]floatValue] < 26.52 || [[[self serumCrText]text]floatValue] > 442) && [[self segScr]selectedSegmentIndex] == 1 ){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for serum creatinine" message:@"Serum creatinine must be between 26.52 and 442 micromoles/liter" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (([[[self urineCrText]text]floatValue] * ([[[self urineVolumeText]text]floatValue] / 100.0) > 4000 && [[self segUCr]selectedSegmentIndex] == 0 && [[self segUrineVolume]selectedSegmentIndex] == 0) || ([[[self urineCrText]text]floatValue] * ([[[self urineVolumeText]text]floatValue] / 100.0) < 500 && [[self segUCr]selectedSegmentIndex] == 0 && [[self segUrineVolume]selectedSegmentIndex] == 0)){
        int num = [[[self urineCrText]text]floatValue] * ([[[self urineVolumeText]text]floatValue] / 100.0);
        NSString *alertString = [NSString stringWithFormat:@"%@%d%@", @"Total urine creatinine excreted in 24 hours is calculated to be ", num, @" milligrams.  Permissible daily excretion of creatinine is 500mg/day to 4000mg/day for this program."];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertString message:@"Verify urine volume and urine creatinine concentration." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (([[[self urineCrText]text]floatValue] * ([[[self urineVolumeText]text]floatValue] * 10) > 4000 && [[self segUCr]selectedSegmentIndex] == 0 && [[self segUrineVolume]selectedSegmentIndex] == 1) || ([[[self urineCrText]text]floatValue] * ([[[self urineVolumeText]text]floatValue] * 10) < 500 && [[self segUCr]selectedSegmentIndex] == 0 && [[self segUrineVolume]selectedSegmentIndex] == 1)){
        int num = [[[self urineCrText]text]floatValue] * ([[[self urineVolumeText]text]floatValue] * 10);
        NSString *alertString = [NSString stringWithFormat:@"%@%d%@", @"Total urine creatinine excreted in 24 hours is calculated to be ", num, @" milligrams.  Permissible daily excretion of creatinine is 500mg/day to 4000mg/day for this program."];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertString message:@"Verify urine volume and urine creatinine concentration." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ((([[[self urineCrText]text]floatValue] / 1000) * ([[[self urineVolumeText]text]floatValue] / 1000) > 26.4 && [[self segUCr]selectedSegmentIndex] == 1 && [[self segUrineVolume]selectedSegmentIndex] == 0) || (([[[self urineCrText]text]floatValue] /1000) * (([[[self urineVolumeText]text]floatValue] / 1000)) < 3.5 && [[self segUCr]selectedSegmentIndex] == 1 && [[self segUrineVolume]selectedSegmentIndex] == 0)){
        float num = (int)((([[[self urineCrText]text]floatValue] / 1000) * ([[[self urineVolumeText]text]floatValue] / 1000)) * 10) / 10.0 ;
        NSString *alertString = [NSString stringWithFormat:@"%@%f%@", @"Total urine creatinine excreted in 24 hours is calculated to be ", num, @" millimoles.  Permissible daily excretion of creatinine is 3.5millimoles/day to 26.4millimoles/day for this program."];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertString message:@"Verify urine volume and urine creatinine concentration." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ((([[[self urineCrText]text]floatValue] / 1000) * ([[[self urineVolumeText]text]floatValue]) > 26.4 && [[self segUCr]selectedSegmentIndex] == 1 && [[self segUrineVolume]selectedSegmentIndex] == 1) || (([[[self urineCrText]text]floatValue] / 1000) * ([[[self urineVolumeText]text]floatValue]) < 3.5 && [[self segUCr]selectedSegmentIndex] == 1 && [[self segUrineVolume]selectedSegmentIndex] == 1)){
        float num = ((int)((([[[self urineCrText]text]floatValue] / 1000) * ([[[self urineVolumeText]text]floatValue]))) * 10) / 10.0 ;
        NSString *alertString = [NSString stringWithFormat:@"%@%f%@", @"Total urine creatinine excreted in 24 hours is calculated to be ", num, @" millimoles.  Permissible daily excretion of creatinine is 3.5millimoles/day to 26.4millimoles/day for this program."];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertString message:@"Verify urine volume and urine creatinine concentration." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
  //  else if (([[[self urineCrText]text]floatValue] < 5 || [[[self serumCrText]text]floatValue] > 200) && [[self segScr]selectedSegmentIndex] == 0 ){
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of range value for urine creatinine" message:@"Urine creatinine must be between 5 and 200 milligrams/deciliter" preferredStyle:UIAlertControllerStyleAlert];
      //  UIAlertAction *act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        //[alert addAction:act];
        //[self presentViewController:alert animated:YES completion:nil];
    //}
    
    
    else{
        
        [[self detailItem]setIsSet:YES];
        if ([[self segUCr]selectedSegmentIndex] == 1)
            [[[self detailItem]urineCr]setUnits:MICRO_MOLES_PER_LITER];
        else
            [[[self detailItem]urineCr]setUnits:MILLIGRAMS_PER_DECILITER];
        if ([[self segUrineVolume]selectedSegmentIndex] == 1)
            [[[self detailItem]urineVolume]setUnit:L];
        else
            [[[self detailItem]urineVolume]setUnit:ML];
        if ([[self segScr]selectedSegmentIndex] == 1)
            [[[self detailItem]serumCr]setUnits:MICRO_MOL_PER_LITER];
        else
            [[[self detailItem]serumCr]setUnits:MG_PER_DECILITER];
        [[[self detailItem]serumCr]setValue:[NSNumber numberWithFloat:[[[self serumCrText]text]floatValue]]];
        [[[self detailItem]urineCr]setValue:[NSNumber numberWithFloat:[[[self urineCrText]text]floatValue]]];
        [[[self detailItem]urineVolume]setVolume:[NSNumber numberWithFloat:[[[self urineVolumeText]text]floatValue]]];
        [[self detailItem]postDidChangeNotification];
        [[self lockButton]setTitle:@"Unlock Information" forState:UIControlStateNormal];
        for (UIControl *con in enabledViews){
            [con setEnabled:NO];
        }
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [recognizer setEnabled:NO];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [recognizer setEnabled:YES];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)hideKeyboard
{
    //[ resignFirstResponder];
    [[self serumCrText]resignFirstResponder];
    //[textFieldAge resignFirstResponder];
    [[self urineVolumeText]resignFirstResponder];
    //[textFieldHeight resignFirstResponder];
    
    [[self urineCrText]resignFirstResponder];
    [recognizer setEnabled:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

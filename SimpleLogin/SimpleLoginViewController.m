//
//  SimpleLoginViewController.m
//  SimpleLogin
//
//  Created by Su Yan Fang on 7/9/13.
//  Copyright (c) 2013 Su Yan Fang. All rights reserved.
//

#import "SimpleLoginViewController.h"
#import "SimpleLoginAppDelegate.h"

@interface SimpleLoginViewController ()

@end

@implementation SimpleLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewdidload");
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSString *fullName = [[res objectForKey:@"user"]objectForKey:@"name"];
    NSString *uuid = [[res objectForKey:@"user"]objectForKey:@"uuid"];
    NSString *deviceType = [[res objectForKey:@"user"]objectForKey:@"device_type"];
    NSString *status = [[res objectForKey:@"user"]objectForKey:@"status"];
    if ([status isEqualToString:@"Successful"]) {
        self.userInfo.text  = [[NSString alloc] initWithFormat:@"Name: %@\nUUID: %@\nDevice Type: %@\nStatus: %@",fullName,uuid,deviceType,status];
        [self.submitButton setEnabled:NO];

    } else {
        self.userInfo.text = status;
        [self.userName selectAll:nil];
    }
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [self setUserName:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.userName) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)login:(id)sender {
    NSString *userId = self.userName.text;
    NSString *deviceType = [UIDevice currentDevice].model;
    NSString *uuid = [UIDevice currentDevice].uniqueIdentifier;
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://localhost:3000/api/users"]];
    NSString *params = [[NSString alloc] initWithFormat:@"user[name]=%@&user[uuid]=%@&user[device_type]=%@",userId,uuid,deviceType];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (IBAction)performLogin:(id)sender {
    SimpleLoginAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
}
@end

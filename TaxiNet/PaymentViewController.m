

#import "PaymentViewController.h"
#import "unity.h"
@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.phonenumber setTitle:self.phone forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissKeyboard {
    [self.txt_distance resignFirstResponder];
    [self.txt_price resignFirstResponder];

}
- (IBAction)callPhone:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString:[NSString stringWithFormat:@"tel:%@",self.phone]];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)SentPayment:(id)sender {
    
    if (self.txt_price.text==nil|| [self.txt_price.text isEqualToString:@""]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"please input price",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if (self.txt_distance.text==nil|| [self.txt_distance.text isEqualToString:@""])
    {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"please input distance",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else
    {
        NSString* requestid = [[NSUserDefaults standardUserDefaults] stringForKey:@"requestID"];
        [unity CompleteTrip:requestid cost:self.txt_price.text distance:self.txt_distance.text];
        [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
        }];
    }

}
@end



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
    
        NSString* requestid = [[NSUserDefaults standardUserDefaults] stringForKey:@"requestID"];
        [unity CompleteTrip:requestid cost:@"300000" distance:@"12"];
        [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
        }];
//    }

}
@end

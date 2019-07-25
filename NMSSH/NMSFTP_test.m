#include "NMSSH.h"

int main() {
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1"
                                        withUsername:@"cici"];

    if (session.isConnected) {
        [session authenticateByPassword:@"093052Hx"];

        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        }
    }
    [session disconnect];
    return 0;
}


%#include "xdr/types.h"

namespace stellar
{
//: WithdrawalRequest contains details regarding a withdraw
struct WithdrawalRequest {
    //: Balance to withdraw from
    BalanceID balance; // balance id from which withdrawal will be performed
    //: Amount to withdraw
    uint64 amount; // amount to be withdrawn
    //: Amount in stats quote asset 
    uint64 universalAmount; // amount in stats asset
    //: Total fee to pay, contains fixed amount and calculated percent of the withdrawn amount
    Fee fee; // expected fee to be paid
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester
    
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}


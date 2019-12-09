%#include "xdr/types.h"

namespace stellar
{

//: Body of a reviewable RedemptionRequest, contains parameters regarding AML alert
struct RedemptionRequest {
    //: Balance to charge assets from. Balance must be in asset owned by requester.
    BalanceID sourceBalanceID;
    //: Account to transfer funds
    AccountID destination;

    //: Amount of redemption
    uint64 amount;

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
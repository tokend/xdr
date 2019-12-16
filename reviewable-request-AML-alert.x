

%#include "xdr/types.h"


namespace stellar
{

    //: Body of a reviewable AMLAlertRequest, contains parameters regarding AML alert
struct AMLAlertRequest {
    //: Target balance to void tokens from
    BalanceID balanceID;

    //: Amount to void
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

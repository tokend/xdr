

%#include "xdr/types.h"

namespace stellar
{
struct CloseDeferredPaymentRequest {
    uint64 deferredPaymentID;

    AccountID destination;
    BalanceID destinationBalance;

    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    uint64 amount;
    PaymentFeeData feeData;

    EmptyExt ext;
};

}


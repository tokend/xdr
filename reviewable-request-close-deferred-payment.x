

%#include "xdr/types.h"

namespace stellar
{
struct CloseDeferredPaymentRequest {
    uint64 deferredPaymentID;

    AccountID destination;
    BalanceID destinationBalance;

    uint64 amount;
    PaymentFeeData feeData;

    EmptyExt ext;
};

}


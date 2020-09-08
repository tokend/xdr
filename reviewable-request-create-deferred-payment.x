

%#include "xdr/types.h"

namespace stellar
{
struct CreateDeferredPaymentRequest {
    BalanceID sourceBalance;
    AccountID destination;

    uint64 amount;
    PaymentFeeData feeData;

    EmptyExt ext;
};

}


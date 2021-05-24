

%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{
struct CreateDeferredPaymentRequest {
    BalanceID sourceBalance;
    AccountID destination;

    uint64 amount;
    uint32 sequenceNumber;

    longstring creatorDetails; // details set by requester

    EmptyExt ext;
};

}

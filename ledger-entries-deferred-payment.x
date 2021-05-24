%#include "xdr/types.h"
%#include "xdr/operation-payment.h"


namespace stellar
{
struct DeferredPaymentEntry
{
    //: ID of the deferred payment entry
    uint64 id;

    uint64 amount;

    longstring details;

    //: Creator of the entry
    AccountID source;
    BalanceID sourceBalance;

    AccountID destination;

    //: Reserved for future extension
    EmptyExt ext;
};
}

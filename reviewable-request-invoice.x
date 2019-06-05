

%#include "xdr/types.h"

namespace stellar
{

struct InvoiceRequest
{
    AssetCode asset;
    uint64 amount; // not allowed to set 0
    BalanceID senderBalance;
    BalanceID receiverBalance;

    uint64 *contractID;
    bool isApproved;
    longstring creatorDetails; // details set by requester

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}


%#include "xdr/types.h"

namespace stellar
{

struct ContractRequest
{
    AccountID customer;
    AccountID escrow;
    longstring creatorDetails; // details set by requester

    uint64 startTime;
    uint64 endTime;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
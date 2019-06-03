%#include "xdr/types.h"

namespace stellar
{

enum ContractState
{
    NO_CONFIRMATIONS = 0,
    CUSTOMER_CONFIRMED = 1,
    CONTRACTOR_CONFIRMED = 2,
    DISPUTING = 4,
    REVERTING_RESOLVE = 8,
    NOT_REVERTING_RESOLVE = 16
};

struct ContractEntry
{
    uint64 contractID;

    AccountID contractor;
    AccountID customer;
    AccountID escrow;

    uint64 startTime;
    uint64 endTime;
    uint64 invoiceRequestsIDs<>;
    longstring initialDetails;

    uint32 state;
    longstring customerDetails;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
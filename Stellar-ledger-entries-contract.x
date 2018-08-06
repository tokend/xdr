%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ContractStatus
{
    NO_CONFIRMATIONS = 0,
    CUSTOMER_CONFIRMED = 1,
    CONTRACTOR_CONFIRMED = 2,
    BOTH_CONFIRMED = 3,
    DISPUTING = 4
};

struct ContractEntry
{
    uint64 contractID;

    AccountID contractor;
    AccountID customer;
    AccountID judge;

    uint64 startTime;
    uint64 endTime;
    longstring details<>;

    ContractStatus status;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
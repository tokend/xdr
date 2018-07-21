%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ContractEntry
{
    uint64 contractID;

    AccountID contractor;
    AccountID customer;
    AccountID judge;

    uint64 invoiceRequestIDs<>;
    uint64 startTime;
    uint64 endTime;
    longstring details;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
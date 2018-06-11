%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-limits-v2.h"

namespace stellar
{

struct PendingStatistics
{
    uint64 statisticsV2ID;
    uint64 requestID;
    uint64 addedAmount;
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
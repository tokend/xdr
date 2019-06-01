%#include "xdr/types.h"

namespace stellar
{

struct PendingStatisticsEntry
{
    uint64 statisticsID;
    uint64 requestID;
    uint64 amount;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
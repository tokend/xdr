

%#include "xdr/types.h"

namespace stellar
{

struct StatisticsEntry
{
	AccountID accountID;

	uint64 dailyOutcome;
	uint64 weeklyOutcome;
	uint64 monthlyOutcome;
	uint64 annualOutcome;

	int64 updatedAt;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}


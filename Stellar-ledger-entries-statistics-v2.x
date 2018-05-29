%#include "xdr/Stellar-types.h"

namespace stellar
{

struct StatisticsEntryV2
{
    uint64 id;
	AccountID   accountID;
	StatsOpType statsOpType;
    AssetCode   assetCode;
    bool        isConvertNeeded;

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
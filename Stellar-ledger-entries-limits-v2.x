%#include "xdr/Stellar-types.h"

namespace stellar
{

enum StatsOpType
{
    PAYMENT_OUT = 1,
    WITHDRAW = 2,
    SPEND = 3,
    DEPOSIT = 4,
    PAYOUT = 5
};

struct LimitsV2Entry
{
    uint64      id;
    AccountType *accountType;
    AccountID   *accountID;
    StatsOpType statsOpType;
    AssetCode   assetCode;
    bool        isConvertNeeded;

    uint64 dailyOut;
    uint64 weeklyOut;
    uint64 monthlyOut;
    uint64 annualOut;

     // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
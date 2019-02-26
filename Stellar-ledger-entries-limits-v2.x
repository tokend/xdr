%#include "xdr/Stellar-types.h"

namespace stellar
{

// `StatsOpType` represents the type of the operation used for statistics purposes
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
    //: ID of the limits entry
    uint64      id;
    //: (optional) ID of the account role limits would be applied to
    uint64*     accountRole;
    //: (optional) ID of the account limits would be applied to
    AccountID*  accountID;
    //: Operation type used in statistics
    StatsOpType statsOpType;
    //: `AssetCode` of the limits entry
    AssetCode   assetCode;
    //: `isConvertNeeded` defines whether the asset conversion is needed for the limits entry
    bool        isConvertNeeded;

    //: daily out limit
    uint64 dailyOut;
    //: weekly out limit
    uint64 weeklyOut;
    //: monthly out limit
    uint64 monthlyOut;
    //: annual out limit
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
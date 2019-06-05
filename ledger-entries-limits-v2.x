%#include "xdr/types.h"

namespace stellar
{

//: `StatsOpType` is a type of operation for which statistics is maintained
enum StatsOpType
{
    PAYMENT_OUT = 1,
    WITHDRAW = 2,
    SPEND = 3,
    DEPOSIT = 4,
    PAYOUT = 5
};

//: `LimitsV2Entry` is used in the system configuration to set limits (daily, weekly, montly, annual)
//: for different assets, operations (according to StatsOpType), particular account roles, particular accounts,
//: or globally (only if both parameters particular account role and paticular account are not specified),
struct LimitsV2Entry
{
    //: ID of limits entry
    uint64      id;
    //: (optional) ID of an account role that will be imposed with limits
    uint64*     accountRole;
    //: (optional) ID of an account that will be imposed with limits
    AccountID*  accountID;
    //: Operation type that will be imposed with limits. See `enum StatsOpType`
    StatsOpType statsOpType;
    //: Asset that will be imposed with limits
    AssetCode   assetCode;
    //: `isConvertNeeded` indicates whether or not the asset conversion is needed for the limits entry.
    //: If this field is `true`, limits are applied to all balances of an account (to every asset that account owns).
    //: Otherwise, limits from particular limits entry are applied only to  balances with `AssetCode` provided by entry.
    bool        isConvertNeeded;

    //: daily out limit
    uint64 dailyOut;
    //: weekly out limit
    uint64 weeklyOut;
    //: monthly out limit
    uint64 monthlyOut;
    //: annual out limit
    uint64 annualOut;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
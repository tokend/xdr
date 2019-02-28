%#include "xdr/Stellar-types.h"

namespace stellar
{

//: `StatsOpType` is a type of operations for which statistics is kept
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
    //: ID of the limits entry
    uint64      id;
    //: (optional) ID of the account role to which limits would be applied
    uint64*     accountRole;
    //: (optional) ID of the account to which limits would be applied
    AccountID*  accountID;
    //: Defines an operation type to which limits would be applied. See `enum StatsOpType`
    StatsOpType statsOpType;
    //: `AssetCode` defines the asset to which limits would be applied
    AssetCode   assetCode;
    //: `isConvertNeeded` indicates whether the asset conversion is needed for the limits entry or not needed.
    //: If this field is `true` - limits are applied to all balances of the account (to every asset account owns).
    //: Otherwise limits from particular limits entry are applied only to the balances with `AssetCode` provided by entry.
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
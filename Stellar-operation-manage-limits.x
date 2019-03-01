%#include "xdr/Stellar-ledger-entries-limits-v2.h"

namespace stellar
{

// `ManageLimitsAction` defines which action could be performed on the Limits entry
enum ManageLimitsAction
{
    CREATE = 0,
    REMOVE = 1
};

//: `LimitsCreateDetails` is used in the system configuration to set limits (daily, weekly, montly, annual)
//: for different assets, operations (according to StatsOpType), particular account roles, particular accounts,
//: or globally (only if both parameters particular account role and paticular account are not specified)
struct LimitsCreateDetails
{
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

/* Manage Limits Options

    Threshold: med

    Result: ManageLimitsResult
*/

//: `ManageLimitsOp` is used to update the limits set in the system
struct ManageLimitsOp
{
    //: `details` defines all details of the operation based on the given `ManageLimitsAction`
    union switch (ManageLimitsAction action)
    {
    case CREATE:
        LimitsCreateDetails limitsCreateDetails;
    case REMOVE:
        uint64 id;
    } details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageLimits Result ********/

//: Result codes for ManageLimits operation
enum ManageLimitsResultCode
{
    // codes considered as "success" for the operation
    //: `ManageLimitsOp` was successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: (reserved for future use) Invalid input
    MALFORMED = -1,
    //: Limits entry not found
    NOT_FOUND = -2,
    //: (reserved for future use) Limits entry already exists
    ALREADY_EXISTS = -3,
    //: Limits cannot be created for account ID and account role simultaneously
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = -4, // FIXME ACC_ROLE ?
    //: Limits entry is invalid (e.g. weeklyOut is less than dailyOut)
    INVALID_LIMITS = -5
};

//: `ManageLimitsResult` defines the result of ManageLimitsOp application based on the given `ManageLimitsResultCode`
union ManageLimitsResult switch (ManageLimitsResultCode code)
{
case SUCCESS:
    struct {
        //: `details` represents the additional information of the `ManageLimitsOp` application result
        union switch (ManageLimitsAction action)
        {
        case CREATE:
            //: ID of the created limits entry
            uint64 id;
        case REMOVE:
            void;
        } details;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
} success;
default:
    void;
};

}

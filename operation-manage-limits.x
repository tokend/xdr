%#include "xdr/ledger-entries-limits-v2.h"

namespace stellar
{

//: `ManageLimitsAction` defines which action can be performed on the Limits entry
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
    //: (optional) ID of an account role that will be imposed with limits
    uint64*     accountRole;
    //: (optional) ID of an account that will be imposed with limits
    AccountID*  accountID;
    //: Operation type to which limits will be applied. See `enum StatsOpType`
    StatsOpType statsOpType;
    //: `AssetCode` defines an asset to which limits will be applied
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

//: `ManageLimitsOp` is used to update limits set in the system
struct ManageLimitsOp
{
    //: `details` defines all details of an operation based on given `ManageLimitsAction`
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
    //: There is no account with passed ID
    ACCOUNT_NOT_FOUND = -1,
    //: Limits entry is not found
    NOT_FOUND = -2,
    //: There is no role with passed ID
    ROLE_NOT_FOUND = -3,
    //: Limits cannot be created for account ID and account role simultaneously
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = -4, // FIXME ACC_ROLE ?
    //: Limits entry is invalid (e.g. weeklyOut is less than dailyOut)
    INVALID_LIMITS = -5,
    //: Asset with provided asset code does not exist
    ASSET_NOT_FOUND = -6
};

//: `ManageLimitsResult` defines the result of ManageLimitsOp application based on given `ManageLimitsResultCode`
union ManageLimitsResult switch (ManageLimitsResultCode code)
{
case SUCCESS:
    struct {
        //: `details` represents an additional information of the `ManageLimitsOp` application result
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

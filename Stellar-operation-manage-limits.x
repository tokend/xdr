%#include "xdr/Stellar-ledger-entries-limits-v2.h"

namespace stellar
{

// `ManageLimitsAction` defines which action would be applied to the Limits entry
enum ManageLimitsAction
{
    CREATE = 0,
    REMOVE = 1
};

// `LimitsCreateDetails` represents all the details of the create limits operation
struct LimitsCreateDetails
{
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

/* Manage Limits Options

    Threshold: med

    Result: ManageLimitsResult
*/

//: `ManageLimitsOp` describes the limits managing operation with the corresponding details
struct ManageLimitsOp
{
    //: `details` defines all details of the operation based on the given `ManageLimitsAction`
    union switch (ManageLimitsAction action)
    {
    case CREATE:
        //: Details of the new limits entry which would be created and stored for a particular account
        LimitsCreateDetails limitsCreateDetails;
    case REMOVE:
        //: ID of the limits entry to remove
        uint64 id;
    } details;

     // reserved for future use
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
    //: `ManageLimitsOp` was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Invalid input
    MALFORMED = -1,
    //: Limits entry not found
    NOT_FOUND = -2,
    //: Limits entry already exists
    ALREADY_EXISTS = -3,
    //: Limits cannot be created for account ID and account role simultaneously fixme role?
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = -4, // FIXME ACC_ROLE ?
    //: Limits entry is invalid (e.g. weeklyOut is less than dailyOut)
    INVALID_LIMITS = -5
};

//: `ManageLimitsResult` defines result of ManageLimits operation based on the given `ManageLimitsResultCode`
union ManageLimitsResult switch (ManageLimitsResultCode code)
{
case SUCCESS:
    struct {
        //: `details` represents the details of the ManageLimits operation result
        union switch (ManageLimitsAction action)
        {
        case CREATE:
            //: ID of the freshly created limits entry
            uint64 id;
        case REMOVE:
            void;
        } details;

		// reserved for future use
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

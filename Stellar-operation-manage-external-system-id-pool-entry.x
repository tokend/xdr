%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/*ManageExternalSystemAccountIdPoolEntry

Threshold: high

Result: ManageExternalSystemAccountIdPoolEntryResult

*/

//: Actions which can be performed with external system account ID in the external system ID pool
enum ManageExternalSystemAccountIdPoolEntryAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateExternalSystemAccountIdPoolEntryActionInput is used to
//: pass necessary params to create new external system account ID in external system ID pool
struct CreateExternalSystemAccountIdPoolEntryActionInput
{
    //: Type of external system, selected arbitrarily
    int32 externalSystemType;
    //: Data for external system binding
    longstring data;
    //: External system ID of creator
    uint64 parent;

    //: Reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: DeleteExternalSystemAccountIdPoolEntryActionInput is used to
//: pass necessary params to remove existing external system account ID in external system ID pool
struct DeleteExternalSystemAccountIdPoolEntryActionInput
{
    //: ID of existing external system account ID pool
    uint64 poolEntryID;

    //: Reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: ManageExternalSystemAccountIdPoolEntryOp is used to create or remove
//: external system account ID from external system ID pool
struct ManageExternalSystemAccountIdPoolEntryOp
{
    //: `actionInput` is used to pass one of
    //: `ManageExternalSystemAccountIdPoolEntryAction` with needed params
    union switch (ManageExternalSystemAccountIdPoolEntryAction action)
    {
    case CREATE:
        CreateExternalSystemAccountIdPoolEntryActionInput createExternalSystemAccountIdPoolEntryActionInput;
    case REMOVE:
        DeleteExternalSystemAccountIdPoolEntryActionInput deleteExternalSystemAccountIdPoolEntryActionInput;
    } actionInput;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageExternalSystemAccountIdPoolEntry Result ********/

//: Result codes of ManageExternalSystemAccountIdPoolEntryOp
enum ManageExternalSystemAccountIdPoolEntryResultCode
{
    //: Specified action in `actionInput` of ManageExternalSystemAccountIdPoolEntryOp
    //: was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Not allowed to pass empty `data`
    MALFORMED = -1,
    //: Not allowed to create external system account ID pool with duplicated
    //: data and external system type
    ALREADY_EXISTS = -2,
    //: There is no external system account ID pool with passed ID
    NOT_FOUND = -3
};

//: Success result of operation applying
struct ManageExternalSystemAccountIdPoolEntrySuccess
{
    //: ID of created external system account ID pool
    uint64 poolEntryID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of operation applying
union ManageExternalSystemAccountIdPoolEntryResult switch (ManageExternalSystemAccountIdPoolEntryResultCode code)
{
case SUCCESS:
    //: `success` if used to pass useful fields after operation applying
    ManageExternalSystemAccountIdPoolEntrySuccess success;
default:
    void;
};

}

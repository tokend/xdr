%#include "xdr/ledger-entries.h"

namespace stellar
{

/*ManageExternalSystemAccountIdPoolEntry

Threshold: high

Result: ManageExternalSystemAccountIdPoolEntryResult

*/

//: Actions that can be performed with an external system account ID in the external system ID pool
enum ManageExternalSystemAccountIdPoolEntryAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateExternalSystemAccountIdPoolEntryActionInput is used to
//: pass necessary params to create a new external system account ID in the external system ID pool
struct CreateExternalSystemAccountIdPoolEntryActionInput
{
    //: Type of external system, selected arbitrarily
    int32 externalSystemType;
    //: Data for external system binding
    longstring data;
    //: External system ID of the creator
    uint64 parent;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: DeleteExternalSystemAccountIdPoolEntryActionInput is used to
//: pass necessary params to remove an existing external system account ID in the external system ID pool
struct DeleteExternalSystemAccountIdPoolEntryActionInput
{
    //: ID of an existing external system account ID pool
    uint64 poolEntryID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: ManageExternalSystemAccountIdPoolEntryOp is used to create or remove
//: an external system account ID from the external system ID pool
struct ManageExternalSystemAccountIdPoolEntryOp
{
    //: `actionInput` is used to pass one of
    //: `ManageExternalSystemAccountIdPoolEntryAction` with required params
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
    //: was performed successfully 
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: It is not allowed to pass empty `data`
    MALFORMED = -1,
    //: It is not allowed to create external system account ID pool with duplicated
    //: data and external system type
    ALREADY_EXISTS = -2,
    //: There is no external system account ID pool with passed ID
    NOT_FOUND = -3
};

//: Success result of operation application
struct ManageExternalSystemAccountIdPoolEntrySuccess
{
    //: ID of the created external system account ID pool
    uint64 poolEntryID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of operation application
union ManageExternalSystemAccountIdPoolEntryResult switch (ManageExternalSystemAccountIdPoolEntryResultCode code)
{
case SUCCESS:
    ManageExternalSystemAccountIdPoolEntrySuccess success;
default:
    void;
};

}

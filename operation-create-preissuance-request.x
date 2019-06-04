%#include "xdr/ledger-entries.h"

namespace stellar
{

/* CreatePreIssuanceRequestOp

    Threshold: high

    Result: CreatePreIssuanceRequestOpResult
*/

//: CreatePreIssuanceRequestOp is used to create a reviewable request,
//: which, after admin's approval, will change `availableForIssuance` amount of asset
struct CreatePreIssuanceRequestOp
{
    //: Body of PreIssuanceRequest to be created
    PreIssuanceRequest request;

    //: (optional) Bit mask whose flags must be cleared in order for PreIssuanceRequest to be approved, which will be used by key `preissuance_tasks` 
    //: instead of key-value
    uint32* allTasks;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreatePreIssuanceRequest Result ********/

//: Result codes of CreatePreIssuanceRequestOp
enum CreatePreIssuanceRequestResultCode
{
    //: Preissuance request is either successfully created
    //: or auto approved if pending tasks of requests is equal to 0
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no asset with such an asset code
    ASSET_NOT_FOUND = -1,
    //: Preissuance request with such reference already exists
    REFERENCE_DUPLICATION = -2,      // reference is already used
    //: Source of operation must be the owner of the asset
    NOT_AUTHORIZED_UPLOAD = -3,      // tries to preissue asset for not owned asset
    //: Only current preissuer can perform preissuance
    INVALID_SIGNATURE = -4,
    //: The summ of preissue, issued, pendingIssuance, available for issuance amounts must not exceed max issued amount
    EXCEEDED_MAX_AMOUNT = -5,
    //: The preissue amount in the preissuance request must exceed 0
    INVALID_AMOUNT = -6,             // amount is 0
    //: The reference field must not be empty
    INVALID_REFERENCE = -7,
    //: Preissue amount must fit the precision of an asset to be issued
    INCORRECT_AMOUNT_PRECISION = -8,  // amount does not fit this asset's precision
    //: Preissuance tasks are not set in the system (i.e., it is not allowed to perform the preissuance)
    PREISSUANCE_TASKS_NOT_FOUND = -9,
    //: `creatorDetails` must be valid json structure
    INVALID_CREATOR_DETAILS = -10
};

//: Result of `CreatePreIssuanceRequest` operation application along with the result code
union CreatePreIssuanceRequestResult switch (CreatePreIssuanceRequestResultCode code)
{
case SUCCESS:
    //: Result of successful application of `CreatePreIssuanceRequest` operation
    struct
    {
        //: ID of created or updated request
        uint64 requestID;
        //: Indicates whether or not the request was auto approved and fulfilled
        bool fulfilled;
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

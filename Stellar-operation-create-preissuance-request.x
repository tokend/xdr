%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreatePreIssuanceRequestOp

    Threshold: high

    Result: CreatePreIssuanceRequestOpResult
*/

//: CreatePreIssuanceRequestOp is used to create reviewable request
//: which after approval from admin will change `availableForIssuance` amount of asset
struct CreatePreIssuanceRequestOp
{
    //: Body of PreIssuanceRequest to be created
    PreIssuanceRequest request;

    //: (optional) Bit mask whose flags must be cleared in order for PreIssuanceRequest to be approved, which will be used
    //: instead of key-value by key `preissuance_tasks`
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
    //: Means that the pre issuance request successfully created
    //: or auto approved if pending tasks of requests was equal to 0
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no asset with such asset code
    ASSET_NOT_FOUND = -1,
    //: Pre issuance request with such reference already exists
    REFERENCE_DUPLICATION = -2,      // reference is already used
    //: Source of operation must be owner of the asset
    NOT_AUTHORIZED_UPLOAD = -3,      // tries to pre issue asset for not owned asset
    //: Only current pre issuer can perform pre issuance
    INVALID_SIGNATURE = -4,
    //: Not allowed to pre issue amount that will give in sum with
    //: issued, pendingIssuance and available for issuance more than max issued amount
    EXCEEDED_MAX_AMOUNT = -5,
    //: Not allowed to create pre issuance request with amount equal to 0
    INVALID_AMOUNT = -6,             // amount is 0
    //: Not allowed to pass empty reference
    INVALID_REFERENCE = -7,
    //: Not allowed to pre issue amount which does not fit to this asset's precision
    INCORRECT_AMOUNT_PRECISION = -8,  // amount does not fit to this asset's precision
    //: There is no value in key value by `preissuance_tasks:<assetCode>` key
    //: or configuration does not allow to pre issue asset with such code
    PREISSUANCE_TASKS_NOT_FOUND = -9,
    //: `creatorDetails` must be valid json structure
    INVALID_CREATOR_DETAILS = -10
};

//: Result of `CreatePreIssuanceRequest` operation application along with result code
union CreatePreIssuanceRequestResult switch (CreatePreIssuanceRequestResultCode code)
{
case SUCCESS:
    //: Result of successful application of `CreatePreIssuanceRequest` operation
    struct
    {
        //: ID of created or updated request
        uint64 requestID;
        //: Indicates whether or not request was auto approved (pending tasks == 0),
        //: amount was successfully pre issued
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

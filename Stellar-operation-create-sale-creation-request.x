

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-review-request.h"

namespace stellar
{

/* CreateSaleCreationRequestOp

        Creates Sale creation request

        Threshold: high

        Result: CreateSaleCreationRequestResult
*/
//: CreateSaleCreationRequest operation creates SaleCreationRequest or updates the rejected request
struct CreateSaleCreationRequestOp
{
    //: ID of the SaleCreationRequest. If set to 0, a new request is created
    uint64 requestID;
    //: SaleCreationRequest details
    SaleCreationRequest request;
    //: (optional) Bit mask whose flags must be cleared in order for CreateSale request to be approved, which will be used by key sale_create_tasks:<asset_code>
    //: instead of key-value
    uint32* allTasks;
    
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateSaleCreationRequest Result ********/
//: CreateSaleCreationRequest result codes
enum CreateSaleCreationRequestResultCode
{
    // codes considered as "success" for the operation
    //: CreateSaleCreationRequest operation was successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Trying to update a reviewable request that does not exist
    REQUEST_NOT_FOUND = -1,
    //: Trying to create a sale for an asset that does not exist
    BASE_ASSET_OR_ASSET_REQUEST_NOT_FOUND = -2,
    //: Trying to create a sale with quote asset that does not exist or
    //: there is no asset pair with default quote asset or other quote assets
    QUOTE_ASSET_NOT_FOUND = -3,
    //: Trying to create a sale with start time > end time
    START_END_INVALID = -4,
    //: Trying to create a sale with end time in the past
    INVALID_END = -5,
    //: Trying to create a sale with 0 price
    INVALID_PRICE = -6,
    //: Trying to create a sale with hard cap < soft cap
    INVALID_CAP = -7,
    //: Max issuance amount is less than sale's soft cap
    INSUFFICIENT_MAX_ISSUANCE = -8,
    //: Trying to create a sale with invalid asset code of one of the assets or base asset is equal to one of the quote assets 
    INVALID_ASSET_PAIR = -9,
    //: Either a reviewable request already exist or a sale with sale parameters
    REQUEST_OR_SALE_ALREADY_EXISTS = -10,
    //: Trying to create SaleCreationRequest with preissued amount that is less than the hard cap
    INSUFFICIENT_PREISSUED = -11,
    //: Creator details must be a valid JSON string
    INVALID_CREATOR_DETAILS = -12,
    //: Version specified in the request is not supported yet
    VERSION_IS_NOT_SUPPORTED_YET = -13,
    //: Tasks for the sale creation request were neither provided in the request nor loaded through KeyValue
    SALE_CREATE_TASKS_NOT_FOUND = -14,
    //: It is not allowed to set all tasks on rejected SaleCreationRequest update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -15,
    //: Due to tasks been 0, we have tried to auto review the request, but it failed
    AUTO_REVIEW_FAILED = -16 
};

//: Result of the successful application of CreateSaleCreationRequest operation
struct CreateSaleCreationSuccess {
    //: ID of the SaleCreation request
    uint64 requestID;
    //: ID of a newly created sale (if the sale creation request has been approved by an admin)
    uint64 saleID;
    //: Indicates whether or not the sale creation request was approved and applied on the creation
    bool fulfilled;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: specifies details on why an auto review has failed
struct CreateSaleCreationAutoReviewFailed {
    //: auto review result
    ReviewRequestResult reviewRequestRequest;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: CreateSaleCreationRequest result along with the result code
union CreateSaleCreationRequestResult switch (CreateSaleCreationRequestResultCode code)
{
case SUCCESS:
    CreateSaleCreationSuccess success;
case AUTO_REVIEW_FAILED:
    CreateSaleCreationAutoReviewFailed autoReviewFailed;
default:
    void;
};

}




%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-review-request.h"

namespace stellar
{

/* CreateSaleCreationRequestOp

        Creates Sale creation request

        Threshold: high

        Result: CreateSaleCreationRequestResult
*/
//: CreateSaleCreationRequest operation creates SaleCreationRequest or updates rejected request
struct CreateSaleCreationRequestOp
{
    //: ID of the SaleCreationRequest. If set to 0 - creates a new one
    uint64 requestID;
    //: SaleCreationRequest details
    SaleCreationRequest request;
    //: Tasks to set on request creation, can be NULL. 
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
    //: Trying to update reviewable request which does not exist
    REQUEST_NOT_FOUND = -1,
    //: Trying to create sale for asset which does not exist
    BASE_ASSET_OR_ASSET_REQUEST_NOT_FOUND = -2,
    //: Trying to create sale with quote asset which does not exist 
    QUOTE_ASSET_NOT_FOUND = -3,
    //: Trying to create sale with start time > end time
    START_END_INVALID = -4,
    //: Trying to create sale with end time in the past
    INVALID_END = -5,
    //: Trying to create sale with 0 price
    INVALID_PRICE = -6,
    //: Trying to create sale with hard cap < soft cap
    INVALID_CAP = -7,
    //: Max issuance amount is lesser than sale's soft cap
    INSUFFICIENT_MAX_ISSUANCE = -8,
    //: Trying to create sale with invalid asset code of one of the assets or base asset is equal to one of the quote assets 
    INVALID_ASSET_PAIR = -9,
    //: Reviewable request or sale with the sale parameters already exists 
    REQUEST_OR_SALE_ALREADY_EXISTS = -10,
    //: Trying to create SaleCreationRequest with preissued amount lesser than hard cap
    INSUFFICIENT_PREISSUED = -11,
    //: Creator details must be a valid JSON 
    INVALID_CREATOR_DETAILS = -12,
    //: Version specified in the request is not supported yet
    VERSION_IS_NOT_SUPPORTED_YET = -13,
    //: Tasks for sale creation request were neither provided in the request nor loaded thru KeyValue
    SALE_CREATE_TASKS_NOT_FOUND = -14,
    //: Not allowed to set all tasks on rejected SaleCreationRequest update
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -15,
    //: due to tasks been 0, we have tried to auto review request, hovewer it failed
    AUTO_REVIEW_FAILED = -16 
};

//: Result of the successful application of CreateSaleCreationRequest operation
struct CreateSaleCreationSuccess {
    //: ID of the SaleCreation request
    uint64 requestID;
    //: ID of the new created sale (if request was fulfilled)
    uint64 saleID;
    //: Boolean indication whether the sale creation request was approved and applied on creation
    bool fulfilled;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: specifies details on why auto review has failed
struct CreateSaleCreationAutoReviewFailed {
    //: auto review result
    ReviewRequestResult reviewRequestRequest;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: CreateSaleCreationRequest result along with result code
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


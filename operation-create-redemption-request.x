%#include "xdr/reviewable-request-redemption.h"

namespace stellar
{

/* CreateRedemptionRequestOp

    Creates redemption request

    Threshold: high

    Result: CreateRedemptionRequestResult
*/
//: CreateRedemptionRequest operation creates a reviewable request
//: that will transfer the specified amount from current holder's balance to destination balance after the reviewer's approval
struct CreateRedemptionRequestOp
{
    //: Reference of RedemptionRequest
    string64 reference; // TODO longstring ?
    //: Parameters of RedemptionRequest
    RedemptionRequest redemptionRequest;
    //: (optional) Bit mask whose flags must be cleared in order for RedemptionRequest to be approved, which will be used by key redemption_tasks
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

/******* CreateRedemptionRequest Result ********/
//: Result codes for CreateRedemption operation
enum CreateRedemptionRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation has been successfully performed
    SUCCESS = 0,

    //codes considered as "failure" for the operation
    //: Redemption is invalid
    INVALID_REDEMPTION = -1,
    //: Tasks for the redemption request were neither provided in the request nor loaded through KeyValue
    REDEMPTION_TASKS_NOT_FOUND = -2,
    //: Creator details must not be empty
    INVALID_CREATOR_DETAILS = -3,
    //: Amount must be greater then 0
    INVALID_AMOUNT = -4,
    //: Reference must not be longer then 64 bytes
    INVALID_REFERENCE = -5,
    //: Source balance with provided balance ID does not exist
    SOURCE_BALANCE_NOT_EXIST = -6, // balance doesn't exist
    //: Amount has incorrect precision
    INCORRECT_PRECISION = -7,
    //: Balance underfunded
    UNDERFUNDED = -8,
    //: Duplicated references are not allowed
    REFERENCE_DUPLICATION = -9,
    //: No destination with provided account ID
    DST_ACCOUNT_NOT_FOUND = -10,
    //: Not allowed to set zero tasks for request
    REDEMPTION_ZERO_TASKS_NOT_ALLOWED = -11,
    //: Not allowed to redeem non-owned asset
    REDEMPTION_NON_OWNED_ASSET_FORBIDDEN = -12
};

//: Result of successful application of `CreateRedemptionRequest` operation
struct RedemptionRequestResponse {
    //: ID of a newly created reviewable request
    uint64 requestID;
    //: Indicates  whether or not the Redemption request was auto approved and fulfilled
    bool fulfilled;

    //: ID of destination balance (may be freshly created)
    BalanceID destinationBalanceID;
    //: Code of an asset used in payment
    AssetCode asset;
    //: Amount sent by the sender
    uint64 sourceSentUniversal;
    //: Reserved for future use
     union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of `CreateRedemptionRequest` operation application along with the result code
union CreateRedemptionRequestResult switch (CreateRedemptionRequestResultCode code)
{
    case SUCCESS:
        RedemptionRequestResponse redemptionResponse;
    default:
        void;
};

}
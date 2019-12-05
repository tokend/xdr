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
    //: Update redemption tasks are not set in the system, i.e. it's not allowed to perform redemption
    REDEMPTION_TASKS_NOT_FOUND = -1,
    //: Holder's balance with provided balance ID does not exist
    CURRENT_HOLDER_BALANCE_NOT_EXIST = -2, // balance doesn't exist
    //: Destination balance with provided balance ID does not exist
    DESTINATION_BALANCE_NOT_EXIST = -3, // balance doesn't exist
    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -4, //invalid reason for request
    //: Specified amount is greater than the amount on the balance
    UNDERFUNDED = -5, //when couldn't lock balance
    //: Redemption request with the same reference already exists
    REFERENCE_DUPLICATION = -6, // reference already exists
    //: Amount must be positive
    INVALID_AMOUNT = -7, // amount must be positive
    //: Amount precision and asset precision set in the system are mismatched
    INCORRECT_PRECISION = -8
};

//: Result of successful application of `CreateRedemptionRequest` operation
struct CreateRedemptionRequestSuccess {
    //: ID of a newly created reviewable request
    uint64 requestID;
    //: Indicates  whether or not the Redemption request was auto approved and fulfilled
    bool fulfilled;
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
        CreateRedemptionRequestSuccess success;
    default:
        void;
};

}
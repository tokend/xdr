

%#include "xdr/Stellar-reviewable-request-AML-alert.h"

namespace stellar
{

/* CreateAMLAlertRequestOp

    Creates AML alert request

    Threshold: high

    Result: CreateAMLAlertRequestResult
*/
//: CreateAMLAlertRequest operation creates a reviewable request that will void the specified amount after approval 
//: from target balance
struct CreateAMLAlertRequestOp
{
    //: Reference of AMLAlertRequest
    string64 reference; // TODO longstring ?
    //: Parameters of AMLAlertRequest
    AMLAlertRequest amlAlertRequest;
    //: (optional) Bit mask whose flags must be cleared in order for AMLAlertRequest to be approved, which will be used by key aml_alert_tasks:<asset_code>
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

/******* CreateAMLAlertRequest Result ********/
//: Result codes for CreateAMLAlert operation
enum CreateAMLAlertRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation has been successfully performed
    SUCCESS = 0,
    //: Balance with provided balance ID does not exist
    BALANCE_NOT_EXIST = 1, // balance doesn't exist
    //: Creator details are not valid JSON
    INVALID_CREATOR_DETAILS = 2, //invalid reason for request
    //: Specified amount is greater than the amount on the balance
    UNDERFUNDED = 3, //when couldn't lock balance
    //: AML Alert request with the same reference already exists
    REFERENCE_DUPLICATION = 4, // reference already exists
    //: Amount must be positive
    INVALID_AMOUNT = 5, // amount must be positive
    //: Amount precision and asset precision set in the system are mismatched
    INCORRECT_PRECISION = 6,

    //codes considered as "failure" for the operation
    //: Update aml alert tasks are not set in the system, i.e. it's not allowed to perform aml alert
    AML_ALERT_TASKS_NOT_FOUND = -1

};

//: Result of successful application of `CreateAMLAlertRequest` operation
struct CreateAMLAlertRequestSuccess {
    //: ID of a newly created reviewable request
    uint64 requestID;
    //: Indicates  whether or not the AMLAlert request was approved and applied on creation
    bool fulfilled;
    //: Reserved for future use
     union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of `CreateAMLAlertRequest` operation application along with the result code
union CreateAMLAlertRequestResult switch (CreateAMLAlertRequestResultCode code)
{
    case SUCCESS:
        CreateAMLAlertRequestSuccess success;
    default:
        void;
};

}

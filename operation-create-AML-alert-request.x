

%#include "xdr/reviewable-request-AML-alert.h"

namespace stellar
{

/* CreateAMLAlertRequestOp

    Creates AML alert request

    Threshold: high

    Result: CreateAMLAlertRequestResult
*/
//: CreateAMLAlertRequest operation creates a reviewable request 
//: that will void the specified amount from target balance after the reviewer's approval
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
    //: DEPRECATED: Balance with provided balance ID does not exist
    OLD_BALANCE_NOT_EXIST = 1, // balance doesn't exist
    //: DEPRECATED: Creator details are not in a valid JSON format
    OLD_INVALID_CREATOR_DETAILS = 2, //invalid reason for request
    //: DEPRECATED: Specified amount is greater than the amount on the balance
    OLD_UNDERFUNDED = 3, //when couldn't lock balance
    //: DEPRECATED: AML Alert request with the same reference already exists
    OLD_REFERENCE_DUPLICATION = 4, // reference already exists
    //: DEPRECATED: Amount must be positive
    OLD_INVALID_AMOUNT = 5, // amount must be positive
    //: DEPRECATED: Amount precision and asset precision set in the system are mismatched
    OLD_INCORRECT_PRECISION = 6,

    //codes considered as "failure" for the operation
    //: Update aml alert tasks are not set in the system, i.e. it's not allowed to perform aml alert
    AML_ALERT_TASKS_NOT_FOUND = -1,
    //: Balance with provided balance ID does not exist
    BALANCE_NOT_EXIST = -2, // balance doesn't exist
    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -3, //invalid reason for request
    //: Specified amount is greater than the amount on the balance
    UNDERFUNDED = -4, //when couldn't lock balance
    //: AML Alert request with the same reference already exists
    REFERENCE_DUPLICATION = -5, // reference already exists
    //: Amount must be positive
    INVALID_AMOUNT = -6, // amount must be positive
    //: Amount precision and asset precision set in the system are mismatched
    INCORRECT_PRECISION = -7

};

//: Result of successful application of `CreateAMLAlertRequest` operation
struct CreateAMLAlertRequestSuccess {
    //: ID of a newly created reviewable request
    uint64 requestID;
    //: Indicates  whether or not the AMLAlert request was auto approved and fulfilled 
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
